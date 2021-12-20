var priceTag, quantityTag, totalTag, selectTag,select_oneTag, card_numberTag;

function init(){
    priceTag = document.getElementById("price_id")
    quantityTag = document.getElementById("quantity_id")
    selectTag = document.getElementById("select_id")
    totalTag = document.getElementById("total_price_id")
    select_oneTag = document.getElementById("slect_one_id")
    card_numberTag = document.getElementsByTagName("card_number")
}

function Subtotal(){
    priceTag.value = selectTag.value
    priceTag.disabled = false
    quantityTag.disabled = false
    totalTag.disabled =false
   
}

function myTotal(){
    price = priceTag.value;
    quantity = quantityTag.value
    totalTag.value = price *quantity
}
 

