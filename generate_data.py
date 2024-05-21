import psycopg2
import random
from datetime import datetime

conn = psycopg2.connect(
    database="postgres",
    user="postgres",
    password="postgres",
    host="localhost",
    port="5432"
)

def get_insert_query(table_name, fields, data):
    fields_query = "(" + ",".join(fields) + ")"
    data_query = "(" + ",".join(data) + ")"
    query = f"insert into {str(table_name)} {fields_query} values {data_query}" + ";"
    return query

def formated_time():
    time = datetime.now()
    year = time.year
    month = time.month if time.month >= 10 else "0" + str(time.month)
    day = time.day if time.day >= 10 else "0" + str(time.day)
    hour = time.hour if time.hour >= 10 else "0" + str(time.hour)
    minute = time.minute if time.minute >= 10 else "0" + str(time.minute)
    second = time.second if time.second >= 10 else "0" + str(time.second)
    '2024-04-04 11:40:11'
    return f"'{year}-{month}-{day} {hour}:{minute}:{second}'"

cur = conn.cursor()

first_names = ['Anton', 'Alex', 'James', 'Jhon', 'Alexa', 
         'Nikita', 'Xi', 'Aragorn', 'Steve', 'Jane', 'Loise', 'Carl']

last_names = ['Nevsky', 'Davis', 'White', 'Wilson', 'Young', 'Ivanov', 'Petrov', 'Lewis']

account_names = ['pleiada', 'killer_2004', 'mc_bulka', 'enter_the_it', 'buy_my_course', 'GedagedegedagadaoVEVO', 'eminem', 'NirvanaOfficial']

mails = ['gmail.com', 'mail.ru', 'yahoo.com', 'yandex.ru']

for i in range(100):
    ac_name = account_names[random.randint(0, len(account_names) - 1)]
    data = [
        f"'{ac_name} {i}'",
        f"'{ac_name + str(random.randint(0, 1000)) + str(i)}'",
        f"'{first_names[random.randint(0, len(first_names) - 1)]}'",
        f"'{last_names[random.randint(0, len(last_names) - 1)]}'",
        f"'{ac_name + str(i) + '@' + mails[random.randint(0, len(mails) - 1)]}'",
        f"'{ac_name} {i}'",
        formated_time()
    ]
    query = get_insert_query('Users', ['AccountName', 'password', 'FirstName', 'LastName', 'Email', 'Slug', 'RegistrationData'], data)
    cur.execute(query)

conn.commit()

result = cur.execute('select * from users')
rows = cur.fetchall()
for row in rows:
    print(row)

conn.commit()

cur.close()
conn.close()

