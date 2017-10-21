function conn= dbconnConfig()
dbname='attendance_system';
username='root';
password='';
driver='com.mysql.jdbc.Driver';
 disp(driver);
dburl=['jdbc:mysql://localhost:3306/' dbname];
%prefdir;
%disp(javaclasspath);
conn=database(dbname,username,password,driver,dburl);