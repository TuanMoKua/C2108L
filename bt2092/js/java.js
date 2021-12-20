acountTag = document.getElementById('acount_id');
passTag = document.getElementById('pass_id');

var acc, pass;
function init(){
    acc = acountTag;
    pass = passTag;
}


function saveFile(){
    var x= acc.value;
    var y= pass.value
    if( x == "" ||y ==""){
        alert("Nhập thông tin đăng nhập!!");
    } 
}