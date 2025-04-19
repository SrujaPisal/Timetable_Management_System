from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector
import logging
from ortools.sat.python import cp_model
import hashlib
from flask import session

app = Flask(__name__)
CORS(app, origins=["http://localhost:5500"], methods=["GET", "POST", "PUT", "DELETE"], supports_credentials=True)
logging.basicConfig(level=logging.DEBUG)

DAYS = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
SLOTS_PER_DAY = 8
TIMESLOTS = [
    '8:30-9:30', '9:30-10:30', '10:45-11:45', '11:45-12:45',
    '1:30-2:30', '2:30-3:30', '3:30-4:30', '4:30-5:30'
]

def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="Sruja@2110",
        database="Timetable_Management_System"
    )

@app.route('/login', methods=['POST'])
def login_user():
    data = request.get_json()
    username = data['username']
    password = data['password']

    # Hash the password using SHA256
    hashed_password = hashlib.sha256(password.encode('utf-8')).hexdigest()

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT * FROM User WHERE username = %s AND password = %s", (username, hashed_password))
    user = cursor.fetchone()

    cursor.close()
    conn.close()

    if user:
        return jsonify({
            'message': 'Login successful',
            'username': user['username'],
            'role': user['role']
        }), 200
    else:
        return jsonify({'error': 'Invalid username or password'}), 401

@app.route('/get_programs', methods=['GET'])
def get_programs():
    # if 'user_id' not in session:
    #     return jsonify({'error': 'Unauthorized'}), 401

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT program_id, name FROM Program")
    programs = cursor.fetchall()
    cursor.close()
    conn.close()
    response = jsonify(programs)
    response.headers.add('Access-Control-Allow-Origin', 'http://localhost:5500')
    response.headers.add('Access-Control-Allow-Credentials', 'true')
    return response

@app.route('/get_courses', methods=['POST'])
def get_courses():
    # if 'user_id' not in session:
    #     return jsonify({'error': 'Unauthorized'}), 401

    program_ids = request.json['program_ids']
    placeholders = ','.join(['%s'] * len(program_ids))

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    query = f"SELECT course_code, name FROM Course WHERE program_id IN ({placeholders})"
    cursor.execute(query, program_ids)
    courses = cursor.fetchall()
    cursor.close()
    conn.close()

    return jsonify(courses)

@app.route('/generate_timetable', methods=['POST'])
def generate_timetable():
  data = request.get_json()
  selected_program_ids = data.get('program_ids', [])
  selected_course_codes = data.get('course_codes', [])




  if not selected_program_ids or not selected_course_codes:
      return jsonify({'error': 'Missing program IDs or course codes'}), 400




  conn = get_db_connection()
  cursor = conn.cursor(dictionary=True)




  try:
      # Fetch course details
      cursor.execute(
          "SELECT * FROM Course WHERE course_code IN (%s)" % ','.join(['%s'] * len(selected_course_codes)),
          tuple(selected_course_codes)
      )
      courses = cursor.fetchall()




      # Fetch professors and rooms
      cursor.execute("SELECT * FROM Professor")
      professors = cursor.fetchall()




      cursor.execute("SELECT * FROM Room")
      rooms = cursor.fetchall()




      # Fetch professor-course assignments
      cursor.execute(
          "SELECT * FROM assigned WHERE course_code IN (%s)" % ','.join(['%s'] * len(selected_course_codes)),
          tuple(selected_course_codes)
      )
      assigned_rows = cursor.fetchall()
      assigned_professors = {row['course_code']: row['prof_id'] for row in assigned_rows}




      # Build course map and validate assignments
      course_map = {}
      missing_professors = []




      for c in courses:
          code = c['course_code']
          prof_id = assigned_professors.get(code)
          if not prof_id:
              missing_professors.append(code)
          else:
              course_map[code] = {
                  'name': c['name'],
                  'professor_id': prof_id,
                  'type': 'Lab' if c['is_lab'] else 'Theory',
                  'credits': c['credits']
              }




      if missing_professors:
          return jsonify({'error': 'Missing professor assignments for courses', 'courses': missing_professors}), 400




      # OR-Tools model
      model = cp_model.CpModel()
      course_slot_vars = {}
      room_assignment_vars = {}
      program_course_slot_vars = {}




      total_slots = len(DAYS) * SLOTS_PER_DAY




      # Define course-slot and room assignment variables
      for code in selected_course_codes:
          for slot in range(total_slots):
              course_slot_vars[(code, slot)] = model.NewBoolVar(f'{code}_slot{slot}')
          room_assignment_vars[code] = model.NewIntVar(0, len(rooms) - 1, f'{code}_room')




      # Define program-course-slot variables
      for pid in selected_program_ids:
          for code in selected_course_codes:
              for slot in range(total_slots):
                  program_course_slot_vars[(pid, code, slot)] = model.NewBoolVar(f'pid{pid}_{code}_slot{slot}')




      # Constraints: Course and Program slot allocations
      for code in selected_course_codes:
          required_slots = 2 if course_map[code]['type'] == 'Lab' else min(course_map[code]['credits'], 4)
          model.Add(sum(course_slot_vars[(code, s)] for s in range(total_slots)) == required_slots)




      for pid in selected_program_ids:
          for code in selected_course_codes:
              required_slots = 2 if course_map[code]['type'] == 'Lab' else min(course_map[code]['credits'], 4)
              model.Add(sum(program_course_slot_vars[(pid, code, s)] for s in range(total_slots)) == required_slots)




      # Conflict: Same course can't be in multiple programs at same time
      for code in selected_course_codes:
          for slot in range(total_slots):
              for i in range(len(selected_program_ids)):
                  for j in range(i + 1, len(selected_program_ids)):
                      pid1 = selected_program_ids[i]
                      pid2 = selected_program_ids[j]
                      model.Add(program_course_slot_vars[(pid1, code, slot)] + program_course_slot_vars[(pid2, code, slot)] <= 1)




      # Conflict: No room clash between different courses
      for slot in range(total_slots):
          for i in range(len(selected_course_codes)):
              for j in range(i + 1, len(selected_course_codes)):
                  code1 = selected_course_codes[i]
                  code2 = selected_course_codes[j]
                  b1 = course_slot_vars[(code1, slot)]
                  b2 = course_slot_vars[(code2, slot)]
                  r1 = room_assignment_vars[code1]
                  r2 = room_assignment_vars[code2]
                  rooms_different = model.NewBoolVar(f'{code1}_{code2}_slot{slot}_room_diff')
                  model.Add(r1 != r2).OnlyEnforceIf(rooms_different)
                  model.Add(r1 == r2).OnlyEnforceIf(rooms_different.Not())




                  # Now safely use in the constraint
                  model.AddBoolOr([b1.Not(), b2.Not(), rooms_different])




      # Ensure room assignments are only valid for lab or lecture rooms
      for code in selected_course_codes:
          room_idx = room_assignment_vars[code]
          if course_map[code]['type'] == 'Lab':
              model.Add(room_idx < len(rooms) - 4)  # First 4 rooms are for labs
          else:
              model.Add(room_idx >= len(rooms) - 4)  # Rooms with index >= len(rooms) - 4 are for lectures




      # Ensure consecutive hours for lab courses
      for code in selected_course_codes:
          if course_map[code]['type'] == 'Lab':
              for slot in range(total_slots - 1):
                  model.Add(course_slot_vars[(code, slot)] + course_slot_vars[(code, slot + 1)] <= 1)




      # Solve model
      solver = cp_model.CpSolver()
      solver.parameters.max_time_in_seconds = 60
      solver.parameters.num_search_workers = 4
      status = solver.Solve(model)




      if status == cp_model.INFEASIBLE:
          return jsonify({'message': 'No feasible timetable. Suggestions: reduce courses, add rooms, check professors'}), 400
      elif status not in [cp_model.OPTIMAL, cp_model.FEASIBLE]:
          return jsonify({'message': 'Unable to generate timetable with current constraints'}), 400




      # Extract timetable entries from solution
      timetable_entries = []
      for pid in selected_program_ids:
          for code in selected_course_codes:
              for slot in range(total_slots):
                  var = program_course_slot_vars.get((pid, code, slot))
                  if var is not None and solver.Value(var) == 1:
                      day_idx = slot // SLOTS_PER_DAY
                      hour_idx = slot % SLOTS_PER_DAY
                      room_idx = solver.Value(room_assignment_vars[code])
                      room = rooms[room_idx]
                      timetable_entries.append({
                          'program_id': pid,
                          'course_code': code,
                          'professor_id': course_map[code]['professor_id'],
                          'room_no': room['room_no'],
                          'day': DAYS[day_idx],
                          'timeslot': hour_idx + 1,
                          'is_lab': 1 if course_map[code]['type'] == 'Lab' else 0
                      })




      # Save timetable to DB
      cursor.execute(
          "DELETE FROM Timetable WHERE program_id IN (%s)" % ','.join(['%s'] * len(selected_program_ids)),
          tuple(selected_program_ids)
      )




      for entry in timetable_entries:
          cursor.execute("""
              INSERT INTO Timetable (program_id, course_code, prof_id, room_no, day, timeslot, is_lab, batch_name)
              VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
          """, (
              entry['program_id'], entry['course_code'], entry['professor_id'],
              entry['room_no'], entry['day'], entry['timeslot'],
              entry['is_lab'], None
          ))




      conn.commit()
      return jsonify({'message': 'Timetable generated successfully!'}), 200




  except Exception as e:
      logging.error(f"Generation error: {e}", exc_info=True)
      return jsonify({'message': f'Internal error: {e}'}), 500




  finally:
      cursor.close()
      conn.close()





@app.route('/view_timetable/<program_id>', methods=['GET'])
def view_timetable(program_id):
    conn = get_db_connection()
    try:
        query = """
            SELECT t.day, t.timeslot, c.name AS course, pr.name AS program_name,
                   p.name AS professor, r.room_no
            FROM Timetable t
            JOIN Course c ON t.course_code = c.course_code
            JOIN Program pr ON c.program_id = pr.program_id
            JOIN Professor p ON t.prof_id = p.prof_id
            JOIN Room r ON t.room_no = r.room_no
            WHERE pr.program_id = %s
        """
        cursor = conn.cursor(dictionary=True)
        cursor.execute(query, (program_id,))
        results = cursor.fetchall()

        if not results:
            return jsonify({"message": "Program Not Found"}), 404

        # Define the mapping of slots to times
        slot_to_time = {
            1: '8:30-9:30', 2: '9:30-10:30', 3: '10:45-11:45', 4: '11:45-12:45',
            5: '1:30-2:30', 6: '2:30-3:30', 7: '3:30-4:30', 8: '4:30-5:30'
        }

        DAYS = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']

        # Initialize a timetable structure for the week
        week_timetable = {day: {slot_to_time[slot]: None for slot in range(1, 9)} for day in DAYS}

        # Populate the timetable with course data
        for row in results:
            day = row['day']
            timeslot = int(row['timeslot'])  # The slot is in the database as 1-8
            if 1 <= timeslot <= 8:
                week_timetable[day][slot_to_time[timeslot]] = {
                    'course': row['course'],
                    'professor': row['professor'],
                    'room': row['room_no']
                }

        return jsonify({
            'days': DAYS,
            'timeslots': [slot_to_time[i] for i in range(1, 9)],
            'week_timetable': week_timetable
        })

    except Exception as e:
        logging.error(f"View timetable error: {e}", exc_info=True)
        return jsonify({'message': 'Error viewing timetable'}), 500
    finally:
        conn.close()

@app.route('/get_rooms', methods=['GET'])
def get_rooms():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT room_no FROM Room")
    rooms = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(rooms)

@app.route('/get_professors', methods=['GET'])
def get_professors():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT prof_id, name FROM Professor")
    professors = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(professors)

@app.route('/view_room_timetable/<room_no>', methods=['GET'])
def view_room_timetable(room_no):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    query = "CALL GetRoomTimetable(%s)"
    cursor.execute(query, (room_no,))
    timetable_entries = cursor.fetchall()

    room_timetable = {}
    for entry in timetable_entries:
        day = entry['day']
        if day not in room_timetable:
            room_timetable[day] = []
        room_timetable[day].append({
            "slot": entry['slot'],
            "program": entry['program_name']
        })

    cursor.close()
    conn.close()
    return jsonify({
        "room_no": room_no,
        "timetable": room_timetable
    })

@app.route('/view_professor_timetable/<string:name>', methods=['GET'])
def view_professor_timetable(name):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    # Call the stored procedure to fetch professor's timetable
    query = "CALL GetProfessorTimetable(%s)"
    cursor.execute(query, (name,))
    data = cursor.fetchall()
    
    cursor.close()
    conn.close()

    # Get unique time slots and days, ensuring correct sorting
    time_slots = sorted(set(row['slot'] for row in data))
    days = sorted(set(row['day'] for row in data), key=lambda x: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'].index(x))

    # Create a dictionary to store the timetable data
    professor_timetable = {}
    for row in data:
        day = row['day']
        slot = row['slot']
        if slot not in professor_timetable:
            professor_timetable[slot] = {}
        professor_timetable[slot][day] = {
            'course': row['course'],
            'program': row['program'],
            'room_no': row['room_no']
        }

    # Create the response object
    response = {
        'professor_name': name,
        'days': days,
        'timetable': []
    }

    # Populate the timetable array, adding room info to the response
    for slot in time_slots:
        row = {'slot': slot}
        for day in days:
            if day in professor_timetable[slot]:
                row[day] = f"{professor_timetable[slot][day]['course']} ({professor_timetable[slot][day]['program']}) - Room: {professor_timetable[slot][day]['room_no']}"
            else:
                row[day] = ''
        response['timetable'].append(row)

    return jsonify(response)


if __name__ == "__main__":
    app.run(debug=True)
