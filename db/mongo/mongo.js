//ref http://zhangshenjia.com/it/mongodb-js/

mongo = new Mongo();
admin = mongo.getDB( "admin" );
admin.auth("xxxxx","yyyyy");

// connect other db
var userDB = connect('127.0.0.1/member');
userDB.user.find();

print( 'Hello World' );

var obj = { 'key' : 'value' };
printjson( obj );
