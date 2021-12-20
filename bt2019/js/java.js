
// khai baos mang chua cac nd can show gắn vs nhau
var storelist = [
    {
        "Name" : "Apple",
        "categroy" : ["Iphone", "Ipad", "Ipod"]
    },
    {
        "Name" : "SamSung",
        "categroy" : ["S1", "S2", "S3"]
    },
    {
        "Name" : "LG",
        "categroy" : ["L1", "L2", "L3"]
    },
    {
        "Name" : "Google",
        "categroy" : ["G1", "G2", "G3"]
        },
]

var productlist =[]// khai báo mảng rỗng để lưu thông tin
// khai báo name tag để truy cập dư liệu đẻ gọi trong các funtion
var prodcutTag, categroyTag, priceTag, quantityTag, totalTag, manufactunerTag;
var showtableTag
//gắn các tage name vào vs các id tương ứng và gọi hàm for để lưu thông tin trong t
function init() {
    prodcutTag = document.getElementById('productname_id');
    categroyTag = document.getElementById('categroy_id');
    priceTag = document.getElementById('price_id');
    quantityTag = document.getElementById('quantity_id');
    totalTag = document.getElementById('total_id');
    showtableTag = document.getElementById('showtable');
    manufactunerTag = document.getElementById("manufactuner_id");

     for(var item of storelist){
        manufactunerTag.innerHTML += ` <option value = "${item.Name}">${item.Name}</option> `
    }

}

function changeManufactuner(){
    manufactunerValue = manufactunerTag.value;
    categroylist =[];

    for(var item of storelist){
        if(item.Name == manufactunerValue){
            categroylist = item.categroy;
            break;
        }
    }

    categroyTag.innerHTML = ' <option value="" >-- Selcet --</option>'
    for(var x of categroylist){
        categroyTag.innerHTML += ` <option value="${x}" >${x}</option>`
    }
}

//' tinh total
function updatePrice(){
    price = priceTag.value;
    quantity = quantityTag.value;
    totalTag.value = price * quantity;
    totalTag.disabled = false

}
// nhapa noi dung vao bang hienj thi ten ng mua hang` va abc

var currentIndex = -1;
function addProduct(){
    adtag= document.getElementById("add-btn")
    
    // taọ mảng lưu trữ thông tin khách hàng
    object = {
        "name" : prodcutTag.value,
        "categroy": categroyTag.value,
        "price" : priceTag.value,
        "quantity" : quantityTag.value,
        "total" : totalTag.value,
        "manufactuner" : manufactunerTag.value
    }
    if(currentIndex >=0){
        productlist[currentIndex] = object;
        currentIndex = -1;
    }else{
        productlist.push(object);
    }

    displayProduct()
    return false;
}

function displayProduct(){
    showtableTag.innerHTML = ' ';
    var index = 0;
    
    for( var item of productlist){
        showtableTag.innerHTML += `
            <tr>
            <th>${index + 1}</th>
            <th>${item.name}</th>
            <th>${item.categroy}</th>
            <th>${item.price}</th>
            <th>${item.quantity}</th>
            <th>${item.total}</th>
            <th>${item.manufactuner}</th>
            <th><button onclick="UpdateItem(${index})">Edit</button></th>
            <th><button onclick="DeleteItem(${index})">Delete</button></th>
        </tr>`
        index++;
    }
    
}


function UpdateItem(index){
    currentIndex = index;
    object = productlist[index];

    prodcutTag.value  = object.name
    categroyTag.value = object.categroy
    priceTag.value = object.price
    quantityTag.value = object.quantity
    totalTag.value = object.price * object.quantity
    manufactunerTag.value = object.manufactuner
}

function DeleteItem(index){
    productlist.splice(index, 1)
	displayProduct()
}