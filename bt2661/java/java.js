
function addStudent(){

    var x = new Array()

    for (let i = 0; i < 3; i++) {
        let a = prompt('Nhap tên sinh viên!!' + i);
        let b = prompt('Nhap tuổi!' + i);
        
        let object={
            "Name" : a, "Tuoi": b
        }

        x.push(object);
    }

    console.log(x);

    var index =0;
     var y = document.getElementById("show");

     for (let i = 0; i < x.length; i++) {
         y.innerHTML += `<tr>
         <td>${++index}</td>
         <td>${x[i].Name}</td>
         <td>${x[i].Tuoi}</td>
         <td></td>
         <td></td>
         </tr> `
         
     }
}


