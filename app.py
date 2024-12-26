from flask import Flask, render_template, request, redirect, url_for
from flask_mysqldb import MySQL

app = Flask(__name__)

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'  
app.config['MYSQL_PASSWORD'] = 'salma'  
app.config['MYSQL_DB'] = 'librart_DB'  

mysql = MySQL(app)

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/borrow', methods=['GET', 'POST'])
def borrow():
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        phone = request.form['phone']
        book_id = request.form['book_id']
        
        cur = mysql.connection.cursor()

        cur.execute("SELECT Member_id FROM Member WHERE email = %s", (email,))
        member = cur.fetchone()

        if member:
          
            member_id = member[0]
        else:
           
            cur.execute("INSERT INTO Member (name, email, phone) VALUES (%s, %s, %s)", (name, email, phone))
            mysql.connection.commit()
            member_id = cur.lastrowid 
   
        cur.execute("INSERT INTO Borrowing (Book_id, Member_id, Borrow_date) VALUES (%s, %s, NOW())", (book_id, member_id))
        mysql.connection.commit()
        cur.close()

        return redirect(url_for('home'))
    return render_template('borrow.html')

@app.route('/search', methods=['GET', 'POST'])
def search():
    if request.method == 'POST':
        search_query = request.form['search']
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM Book WHERE title LIKE %s OR author LIKE %s", ('%' + search_query + '%', '%' + search_query + '%'))
        books = cur.fetchall()
        cur.close()
        return render_template('search.html', books=books)
    return render_template('search.html', books=[])

if __name__ == '__main__':
    app.run(debug=True)
