
from flask_mail import Mail, Message
from flask import Flask, render_template, request, redirect, url_for, session,jsonify
from flask_mysqldb import MySQL,MySQLdb
from werkzeug.utils import secure_filename
from datetime import datetime
import os
import re
import hashlib
import random
import string


app = Flask(__name__)

# Change this to your secret key (can be anything, it's for extra protection)
app.secret_key = 'your secret key'

# Enter your database connection details below
app.config['MYSQL_HOST'] = '127.0.0.1'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'root'
app.config['MYSQL_PORT'] = 3307
app.config['MYSQL_DB'] = 'olx'

UPLOAD_FOLDER_PRODUCTS = './static/img/products'
app.config['UPLOAD_FOLDER_PRODUCTS'] = UPLOAD_FOLDER_PRODUCTS

app.config['MAIL_SERVER']='smtp.hostinger.com'
app.config['MAIL_PORT'] = 465
app.config['MAIL_USERNAME'] = 'mail@accenta.in'
app.config['MAIL_PASSWORD'] = 'Mail@123'
app.config['MAIL_USE_TLS'] = False
app.config['MAIL_USE_SSL'] = True

mail=Mail(app)

mysql = MySQL(app)


app.config.from_pyfile('config.py')

# @app.route('/')
# def index():
#     return render_template('user/index.html')


   


    
@app.route('/adminlogin', methods=['POST','GET'])
def adminlogin():
    if request.method=='GET':
        return render_template('admin/adminlogin.html')
    else:
        username=request.form['username']
        password=request.form['password']
        salt="5gz"
        db_password = password+salt
        encr_pass = hashlib.md5(db_password.encode())
        query='select * from admin_login where username=%s and password=%s'
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        result=cursor.execute(query,(username,encr_pass.hexdigest()))
        account = cursor.fetchone()
        if account:
            session['adminlogin'] = account
            return jsonify({'status':True})
        else:
            return jsonify({'status':False})
  
       
@app.route('/dashboard')
def dashboard():
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    query1 = "SELECT COUNT(id) AS  count FROM add_category "
    cursor.execute(query1)
    category = cursor.fetchone()

    query1 = "SELECT COUNT(id) AS  count FROM submit_ad"
    cursor.execute(query1)
    ads = cursor.fetchone()

    query1 = "SELECT COUNT(id) AS  count FROM submit_ad where verification_status='Blocked'"
    cursor.execute(query1)
    blockedads = cursor.fetchone()

    query1 = "SELECT COUNT(id) AS  count FROM user_registration "
    cursor.execute(query1)
    customers = cursor.fetchone()
    return render_template('admin/dashboard.html',category=category,ads=ads,blockedads=blockedads,customers=customers)

         
@app.route('/userlogout')
def userlogout():
    session. clear()
    return redirect("/")

@app.route('/adminlogout')
def adminlogout():
    session. clear()
    return redirect("/adminlogin")

    

@app.route('/accountsettings')
def accountsettings():
    cust_id=session['userDatas']['id']

    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    query='SELECT * FROM `submit_ad` where customer_id=%s'
    cursor.execute(query,[cust_id])
    ads = cursor.fetchall()

    query='SELECT * FROM `user_registration` where id=%s'
    cursor.execute(query,[cust_id])
    user = cursor.fetchone()
    return render_template('user/accountsettings.html',ads=ads,user=user)


@app.route('/userslist')
def  userslist():
    return render_template('admin/userslist.html')

      

@app.route('/usersdatatable')
def  usersdatatable():
    return render_template('admin/usersdatatable.html')

@app.route('/categories')
def categories():
    query='select * from add_category' 
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute(query)
    categoryDatas = cursor.fetchall()
    return render_template('admin/categories.html',categoryDatas=categoryDatas)

@app.route('/profile')
def  profile():
    return render_template('admin/profile.html')

    
@app.route('/product/<category_id>')
def product(category_id):
    query='select * from submit_ad where categoryid=%s and verification_status="Active" order by id desc' 
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute(query,([category_id]))
    categoryDatas = cursor.fetchall()
    return render_template('user/product.html',categoryDatas=categoryDatas)
    
@app.route('/order')
def  order():
    return render_template('admin/order.html')

    
@app.route('/registration', methods=['GET','POST','PUT'])
def  registration():
    if request.method=="GET":
        return render_template('user/registration.html',edit='')
    elif request.method=="POST":
    #     username=request.form['username']
    #     email=request.form['email']
    #     password=request.form['password']
    #     phoneno=request.form['phoneno']
    #     salt="5gz"
    #     db_password = password+salt
    #     encr_pass = hashlib.md5(db_password.encode())
    #     query='UPDATE user_registration SET username = %s, email = %s, password = %s, phoneno = %s WHERE id = %s'
    #     cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    #     cursor.execute(query,(username,email,password,phoneno,editId))
    #     mysql.connection.commit()
    #     return jsonify({'status':True}) 
    # else:
        username=request.form['username']
        email=request.form['email']
        password=request.form['password']
        phoneno=request.form['phoneno']
        salt="5gz"
        db_password = password+salt
        encr_pass = hashlib.md5(db_password.encode())
        query='INSERT INTO `user_registration` (`username`,`email`,`password`,`phoneno`) VALUES (%s,%s,%s,%s)'
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute(query,(username,email,encr_pass.hexdigest(),phoneno))
        mysql.connection.commit()
        # Generate random OTP & asiign to a variable
        random_number = random.randint(1,10000)
        query='INSERT INTO `otps` (`email`,`otp`) VALUES (%s,%s)'
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute(query,(email,random_number))
        mysql.connection.commit()
        # send mail
        msg = Message('Hello', sender = 'mail@accenta.in', recipients = [email])
        msg.body = "Hello, Your one time OTP is "+str(random_number)
        mail.send(msg)
        return jsonify({'status':True})  


@app.route('/userlogin', methods=['POST','GET'])
def userlogin():
    if request.method=='GET':
        return render_template('user/userlogin.html')
    else:
        username=request.form['username']
        password=request.form['password']
        salt="5gz"
        db_password = password+salt
        encr_pass = hashlib.md5(db_password.encode())
        query='select * from user_registration where email=%s and password=%s'
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        result=cursor.execute(query,(username,encr_pass.hexdigest()))
        account = cursor.fetchone()
        if account!=None:
            if account['status']=='Blocked':
                return jsonify({'status':'Blocked'})
            else:
                session['userDatas'] = account
                return jsonify({'status':True})
        else:
            message="Invalid Credentials"
            return jsonify({'status':False})
  
     

@app.route('/usercategories')
def  usercategories():
    return render_template('user/usercategories.html')


@app.route('/')
def index():
    session['PROJECT_NAME']=app.config['PROJECT_NAME']
    search = request.args.get('search')
    if search:
        query="select * from submit_ad LEFT JOIN add_category ON submit_ad.categoryid = add_category.id  where concat(add_category.name,title,brand,type1,price) LIKE '%{s}%' order by submit_ad.id desc ".format(s=search) 
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute(query)
        searchResults = cursor.fetchall()
        return render_template('user/searchResults.html',searchResults=searchResults)
    else:   
        query='select * from add_category where status="Active"' 
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute(query)
        categoryDatas = cursor.fetchall()
        return render_template('user/index.html',categoryDatas=categoryDatas)


@app.route('/add_category', methods=['GET','POST','PUT'])
def add_category():
    if request.method=="GET":
        return render_template('admin/add_category.html',edit='')
    elif request.method=="PUT":
        name=request.form['name']
        status=request.form['status']
        isthisFile = request.files.get('image')
        editId = request.form['editId']
        if isthisFile:
            isthisFile.save('./static/uploads/' + isthisFile.filename)
            query='UPDATE add_category SET name = %s, status = %s,  image = %s WHERE id = %s'
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute(query,(name,status,isthisFile.filename,editId))
            mysql.connection.commit()
            return jsonify({'status':True})
        else:
            query='UPDATE add_category SET name = %s, status = %s WHERE id = %s'
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute(query,(name,status,editId))
            mysql.connection.commit()
            return jsonify({'status':True})  
    else:
        name=request.form['name']
        status=request.form['status']
        isthisFile = request.files.get('image')
        isthisFile.save('./static/uploads/' + isthisFile.filename)
        query='INSERT INTO `add_category` (`name`,`status`,`image`) VALUES (%s,%s,%s)'
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute(query,(name,status,isthisFile.filename))
        mysql.connection.commit()
        return jsonify({'status':True})  




@app.route('/editCategory/<editId>', methods=['GET','POST'])
def editCategory(editId):
    query='select * from add_category where id=%s' 
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute(query,[editId])
    category = cursor.fetchone()
    return render_template('admin/add_category.html',category=category,edit=True)



@app.route('/delete_category', methods=['POST'])
def delete_category():
    deleteId=request.form['deleteId']
    query='DELETE  FROM `add_category` where id=%s'
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute(query,([deleteId]))
    mysql.connection.commit()
    return jsonify({'status':True})
# [end] of upd ,dlt & create of category




@app.route('/profile-setting')
def  profilesetting():
    return render_template('admin/profile-setting.html')
  



@app.route('/submit_ad', methods=['GET','POST','PUT'])
def submit_ad():
    if request.method=="GET":
        # return render_template('user/submit_ad.html',edit='')       
        query='select * from add_category WHERE status = "Active"' 
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute(query)
        categoryDatas = cursor.fetchall()
        return render_template('user/submit_ad.html',categoryDatas=categoryDatas)
    elif request.method=="PUT":
        title=request.form['title']
        categoryid=request.form['categoryid']
        brand=request.form['brand']
        condition=request.form['condition']
        type1=request.form['type1']
        description=request.form['description']
        price=request.form['price']
        manufacturers=request.form['manufacturers']
        isthisFile1 = request.files.get('image1')
        isthisFile2 = request.files.get('image2')
        isthisFile3 = request.files.get('image3')
        name=request.form['name']
        email=request.form['email']
        phone=request.form['phone']
        state=request.form['state']
        city=request.form['city']
        po=request.form['po']
        address=request.form['address']
        editId = request.form['editId']
        customer_id=session['userDatas']['id']

        if isthisFile1:
            isthisFile1.save('./static/uploads/' + isthisFile1.filename)
            isthisFile2.save('./static/uploads/' + isthisFile2.filename)
            isthisFile3.save('./static/uploads/' + isthisFile3.filename)
            query='UPDATE submit_ad SET title = %s, categoryid = %s, brand = %s, condition = %s, type1 = %s, description = %s, price = %s, manufacturers = %s, image = %s, name = %s, email = %s, phone = %s, state = %s, city = %s,po = %s, address = %s,customer_id=%s WHERE id = %s'
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute(query,(title,categoryid,brand,condition,type1,description,price,manufacturers,isthisFile1.filename,isthisFile2.filename,isthisFile3.filename,name,email,phone,state,city,po,address,editId,customer_id))
            mysql.connection.commit()
            return jsonify({'status':True})
        else:
            query='UPDATE submit_ad SET title = %s, categoryid = %s, brand = %s, condition = %s, type1 = %s, description = %s, price = %s, manufacturers = %s, image = %s, name = %s, email = %s, phone = %s, state = %s, city = %s,po = %s, address = %s,customer_id=%s WHERE id = %s'
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute(query,(title,categoryid,brand,condition,type1,description,price,manufacturers,isthisFile1.filename,isthisFile2.filename,isthisFile3.filename,name,email,phone,state,city,po,address,editId,customer_id))
            mysql.connection.commit()
            return jsonify({'status':True})  
    else:
        title=request.form['title']
        categoryid=request.form['categoryid']
        brand=request.form['brand']
        condition=request.form['condition']
        type1=request.form['type1']
        description=request.form['description']
        price=request.form['price']
        manufacturers=request.form['manufacturers']
        isthisFile1 = request.files.get('image1')
        isthisFile2 = request.files.get('image2')
        isthisFile3 = request.files.get('image3')
        name=request.form['name']
        email=request.form['email']
        phone=request.form['phone']
        state=request.form['state']
        city=request.form['city']
        po=request.form['po']
        address=request.form['address']
        isthisFile1.save('./static/uploads/' + isthisFile1.filename)
        isthisFile2.save('./static/uploads/' + isthisFile2.filename)
        isthisFile3.save('./static/uploads/' + isthisFile3.filename)
        customer_id=session['userDatas']['id']
        query='INSERT INTO `submit_ad` (`title`,`categoryid`,`brand`,`condition`,`type1`,`description`,`price`,`manufacturers`,`image1`,`image2`,`image3`,`name`,`email`,`phone`,`state`,`city`,`po`,`address`,`customer_id`) values (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)'
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute(query,(title,categoryid,brand,condition,type1,description,price,manufacturers,isthisFile1.filename,isthisFile2.filename,isthisFile3.filename,name,email,phone,state,city,po,address,customer_id))
        mysql.connection.commit()
        return jsonify({'status':True})  


@app.route('/editad/<editId>', methods=['GET','POST'])
def editad(editId):
    query='select * from submit_ad where id=%s' 
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute(query,[editId])
    category = cursor.fetchone()
    return render_template('user/submit_ad.html',category=category,edit=True)



@app.route('/delete_ad', methods=['POST'])
def delete_ad():
    deleteId=request.form['deleteId']
    query='DELETE  FROM `submit_ad` where id=%s'
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute(query,([deleteId]))
    mysql.connection.commit()
    return jsonify({'status':True})
# [end] of upd ,dlt & create of category


@app.route('/single_product/<id>')
def single_product(id):
    query='SELECT * FROM `submit_ad` where id=%s'
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute(query,([id]))
    categoryDatas = cursor.fetchone()

    # Reports
    query='SELECT count(customer_id) from  `reports` where customer_id=%s'
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute(query,([categoryDatas['customer_id']]))
    reportsCount = cursor.fetchone()
    fav=None
    if 'userDatas' in session:
        query='SELECT * FROM `chat_groups` where sender=%s and product_id=%s'
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute(query,(session['userDatas']['id'],categoryDatas['id']))
        chat = cursor.fetchone()

        query='SELECT *FROM favourites where user_id=%s and product_id=%s'
        cursor.execute(query,(session['userDatas']['id'],categoryDatas['id']))
        favourites = cursor.fetchone()
        if favourites:
            fav='Added'
        else:
            fav='Not_Add'
    else:
        chat = 'Unauth'
    return render_template('user/single_product.html',categoryDatas=categoryDatas,chat=chat,fav=fav,reportsCount=reportsCount)



    # otp verification start

@app.route('/send_otp',methods=['POST'])
def send_otp():
    email=request.form['email']
    query='SELECT * FROM `user_registration` WHERE email = %s'
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute(query,([email]))
    user_account = cursor.fetchone()
    if user_account:
        random_number = random.randint(1,10000)
        # Generate random OTP & asiign to a variable
        query='INSERT INTO `otps` (`email`,`otp`) VALUES (%s,%s)'
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute(query,(email,random_number))
        mysql.connection.commit()
        # send mail
        msg = Message('Hello', sender = 'mail@accenta.in', recipients = [email])
        msg.body = "Hello, Your one time OTP is "+str(random_number)
        mail.send(msg)
        return jsonify({'status':True})       
    else:
        return jsonify({'status':"notfound"})

@app.route('/verifyOtp',methods=['POST'])
def verifyOtp():
    email=request.form['email']
    otp=request.form['otp']
    query1='SELECT * FROM `otps` WHERE email = %s and otp = %s and status = "pending" '
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute(query1,(email,otp))
    account1 = cursor.fetchone()
    if account1:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        query2='UPDATE otps SET status = "Verified" WHERE email = %s and otp = %s'
        cursor.execute(query2,(email,otp))
        mysql.connection.commit()
        query3='SELECT * FROM `user_registration` WHERE email = %s '
        cursor.execute(query3,([email]))
        account2 = cursor.fetchone()
        session['user_login'] = account2
        return jsonify({'status':True})
    else:
        return jsonify({'status':False})


 # otp verification end

@app.route('/verification')
def  verification():
    return render_template('user/verification.html')

    
# @app.route('/forgetpassword')
# def  forgetpassword():
#     return render_template('user/forgetpassword.html')

@app.route('/forgetpassword', methods=['POST','GET'])
def forgetpassword():
    if request.method=='GET':
        return render_template('user/forgetpassword.html')
    else:
        email=request.form['email']
        query="select * from user_registration where email=%s"
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        result=cursor.execute(query,(email))
        account = cursor.fetchone()
        print (account)
        if account!=None:
            session['userDatas'] = account
            return jsonify({'status':True})
        else:
            message="Invalid Credentials"
            return jsonify({'status':False})
     

  
@app.route('/changepassword')
def  changepassword():
    return render_template('user/changepassword.html')


@app.route('/editpassword/<editId>', methods=['GET','POST'])
def editpassword(editId):
    query='select * from user_registration where id=%s' 
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute(query,[editId])
    passwordDatas = cursor.fetchone()
    return render_template('/',passwordDatas=passwordDatas,edit=True)

@app.route('/sendMessage',methods=['POST'])
def sendMessage():
    sender_id=session['userDatas']['id']
    message=request.form['message']
    receiver_id=request.form['receiver_id']
    product_id=request.form['product_id']

    query='select * from chat_groups where sender=%s and receiver=%s and product_id=%s'
    cursor=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute(query,(sender_id,receiver_id,product_id))
    sendChatGroup= cursor.fetchone()

    query='select * from chat_groups where receiver=%s and sender=%s and product_id=%s'
    cursor=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute(query,(sender_id,receiver_id,product_id))
    receiveChatGroup= cursor.fetchone()

    if sendChatGroup:
        chat_id=sendChatGroup['id']
    elif receiveChatGroup:
         chat_id=receiveChatGroup['id']
    else:
        query='INSERT INTO `chat_groups` (`sender`,`receiver`,`product_id`,`last_update`) VALUES (%s,%s,%s,%s)'
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        result=cursor.execute(query,(sender_id,receiver_id,product_id,datetime.now()))
        mysql.connection.commit()
        chat_id=cursor.lastrowid


    query='INSERT INTO `messages` (`chat_id`,`messenger_id`,`date`,`message`) VALUES (%s,%s,%s,%s)'
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    result=cursor.execute(query,(chat_id,sender_id,datetime.today(),message))
    mysql.connection.commit()
    return jsonify({'status':True,'chat_id':chat_id}) 

@app.route('/cust_chat')
def  cust_chat():

    sender_id=session['userDatas']['id']
    query='select * FROM chat_groups LEFT JOIN submit_ad ON chat_groups.product_id = submit_ad.id  LEFT JOIN user_registration as receiver ON chat_groups.receiver = receiver.id LEFT JOIN user_registration as sender ON chat_groups.sender = sender.id where chat_groups.sender=%s or chat_groups.receiver=%s order by chat_groups.last_update desc'
    cursor=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute(query,(sender_id,sender_id))
    chatGroups=cursor.fetchall()

    receiver_id = request.args.get('receiver_id')
    if receiver_id:
        query='select * FROM user_registration where id=%s'
        cursor=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute(query,([receiver_id]))
        receiverData=cursor.fetchone()
    else:
        receiverData=''

    product_id = request.args.get('product_id')

    if product_id:
        query='select * FROM submit_ad where id=%s'
        cursor=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute(query,([product_id]))
        productData=cursor.fetchone()
    else:
        productData=''
    
    group_id = request.args.get('group_id')
    if group_id:
        query='select * FROM messages  where chat_id=%s'
        cursor=mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute(query,([group_id]))
        messages=cursor.fetchall()
    else:
        messages=[]
    return render_template('user/cust_chat.html',chatGroups=chatGroups,messages=messages,receiverData=receiverData,productData=productData)


@app.route('/sendUserMessage',methods=['POST'])
def sendUserMessage():
    message=request.form['message']
    group_id=request.form['group_id']
    sender_id=session['userDatas']['id']
    query='INSERT INTO `messages` (`chat_id`,`messenger_id`,`date`,`message`) VALUES (%s,%s,%s,%s)'
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    result=cursor.execute(query,(group_id,sender_id,datetime.today(),message))
    mysql.connection.commit()

    query='UPDATE chat_groups SET last_update = %s WHERE id = %s'
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute(query,(datetime.now(),group_id))
    mysql.connection.commit() 


    return jsonify({'status':True,'chat_id':group_id}) 


@app.route('/changeAdStatus', methods=['POST'])
def  changeAdStatus():
    status = request.form['status']
    id = request.form['id']
    query='UPDATE submit_ad SET verification_status = %s WHERE id = %s'
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute(query,(status,id))
    mysql.connection.commit() 
    return jsonify({'status':True})

@app.route('/changeCustomerStatus', methods=['POST'])
def  changeCustomerStatus():
    status = request.form['status']
    id = request.form['id']
    query='UPDATE user_registration SET status = %s WHERE id = %s'
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute(query,(status,id))
    mysql.connection.commit() 
    return jsonify({'status':True})



@app.route('/adm_products', methods=['GET'])
def  adm_products():
    type = request.args.get('type')
    query='select * from submit_ad LEFT JOIN add_category ON submit_ad.categoryid = add_category.id where verification_status=%s' 
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute(query,([type]))
    ads = cursor.fetchall()
    return render_template('admin/ads.html',ads=ads)

@app.route('/adm_customers', methods=['GET'])
def  adm_customers():
    type = request.args.get('type')
    query='select * from user_registration where status=%s' 
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute(query,([type]))
    customers = cursor.fetchall()
    for customer in customers:
        query='select count(customer_id) from reports where customer_id=%s' 
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute(query,([customer['id']]))
        reports = cursor.fetchone()
        customer['reports']=0
        customer['reports']=reports['count(customer_id)']
    return render_template('admin/customers.html',customers=customers)


@app.route('/forget_pass', methods=['GET','POST'])
def  forget_pass():
    if request.method=="GET":
        return render_template('user/forget_pass.html')
    else:
        email=request.form['email']
        query='select *  from user_registration where email=%s'
        cursor1 = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor1.execute(query,([email]))
        customer = cursor1.fetchone()
        if customer:
            salt = "5gz"
            password=''.join(random.choices(string.ascii_uppercase + string.ascii_lowercase, k=5))
            db_password = password+salt
            encr_pass = hashlib.md5(db_password.encode())

            msg = Message('Hello', sender = 'mail@accenta.in', recipients = [email])
            msg.body = "Hello, Your password is "+str(password)
            mail.send(msg)

            query='UPDATE  user_registration set password=%s WHERE id = %s'
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute(query,(encr_pass.hexdigest(),customer['id']))
            mysql.connection.commit()
            return jsonify({'status':True})   
        else:
            return jsonify({'status':'not_found'}) 
        
            

@app.route('/change_password', methods=['GET','POST'])
def change_password():
        curr_pass=request.form['curr_pass']
        new_pass=request.form['new_pass']
        conf_pass=request.form['conf_pass']
        query='select * from user_registration where id=%s' 
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        result=cursor.execute(query,([session['userDatas']['id']]))
        user = cursor.fetchone()

        salt = "5gz"
        db_password = curr_pass+salt
        curr_encr_pass = hashlib.md5(db_password.encode())

        salt = "5gz"
        new_db_password = new_pass+salt
        new_encr_pass = hashlib.md5(new_db_password.encode())
       
        if new_pass !=conf_pass:
            return jsonify({'status':False,'message':'New Password & Confirm Password not match'})   
        
        if curr_encr_pass.hexdigest()==user['password']:
            query='UPDATE user_registration SET password=%s WHERE id = %s'
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute(query,(new_encr_pass.hexdigest(),session['userDatas']['id']))
            mysql.connection.commit()
            return jsonify({'status':True,'message':'Password Changed'})   

        else:
            return jsonify({'status':False,'message':'Current password not match.'})   



@app.route('/addToWishlist', methods=['POST'])
def  addToWishlist():
    prod_id = request.form['prod_id']

    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    query='SELECT *FROM favourites where user_id=%s and product_id=%s'
    cursor.execute(query,(session['userDatas']['id'],prod_id))
    favourites = cursor.fetchone()
    if favourites:
        query='DELETE  FROM `favourites` where id=%s'
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute(query,([favourites['id']]))
        mysql.connection.commit()
    else:    
        query='INSERT INTO `favourites` (`user_id`, `product_id`) VALUES (%s,%s)'
        result=cursor.execute(query,(session['userDatas']['id'],prod_id))
        mysql.connection.commit()
    return jsonify({'status':True})

@app.route('/favourites', methods=['GET'])
def  favourites():
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    query='SELECT *FROM favourites LEFT JOIN submit_ad ON favourites.product_id = submit_ad.id  where user_id=%s'
    cursor.execute(query,([session['userDatas']['id']]))
    favourites = cursor.fetchall()
    return render_template('user/favourites.html',favourites=favourites)

@app.route('/reportCust', methods=['POST'])
def  reportCust():
    customer_id = request.form['customer_id']
    reason = request.form['reason']
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    query='INSERT INTO `reports` (`customer_id`, `reason`) VALUES (%s,%s)'
    result=cursor.execute(query,(customer_id,reason))
    mysql.connection.commit()
    return jsonify({'status':True})

@app.route('/adm_reports', methods=['GET'])
def  adm_reports():
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    query='SELECT *FROM reports LEFT JOIN user_registration ON reports.customer_id = user_registration.id order by reports.id desc'
    cursor.execute(query)
    reports = cursor.fetchall()
    return render_template('admin/reports.html',reports=reports)




if __name__ == "_main_":
    app.run(debug=True)