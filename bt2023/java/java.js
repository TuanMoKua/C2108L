function showproduct(){
    // var x = document.getElementById("product");
    // var y =  document.getElementById("price");

    // y.value = x.value;

    var x = document.getElementById("product").value;

    document.getElementById("price").value = x;

    document.getElementById("quantity").disabled = false


}

function sumtotal(){
    var y= document.getElementById("price");S
    var z = document.getElementById("quantity");
    var k = document.getElementById("total");
    var sum = y.value * z.value;
    k.value = sum;
}

function shownumber(){
    var a = document.getElementsByClassName("card-number");
    for (let i = 0; i < a.length; i++) {
        a[i].disabled = false;
    }

}

