let theme, flag = true;
theme = document.getElementById("theme");
// #5680E9 - #84CEEB - #5AB9EA - #C1C8E4 - #8860D0


function createLabel(elem, name, textLabel, typeOfInput, pattertn){
    let test1 = document.createElement("label"),
    test2 = document.createElement("input");
    test2.type = typeOfInput;
    test2.name = name;
    test2.required = "True";
    if (pattertn != "no"){
        test2.pattern = pattertn;
    }
    test1.innerHTML = textLabel;
    test1.appendChild(test2);
    elem.appendChild(test1);
}

function createButton(elem){
    let test = document.createElement("input");
    test.type = "submit";
    test.value = "Enter";
    test.className = "but";
    elem.appendChild(test);
}

let elem = document.querySelectorAll(".down_text")// первые 2

// создание/удаление входа
let flag1 = true;
elem[0].childNodes[1].onclick = function(){
    if (flag1){
    createLabel(elem[0], "inMail", "Enter mail", "email", "no");
    createLabel(elem[0], "inPass", "Enter pass", "password",
                         "(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{6,}");
    createButton(elem[0]);
    flag1= false;
    
    }// else - удалить
    else{
        for (i=0;i<3;i++){
            elem[0].childNodes[3].parentNode.removeChild(elem[0].childNodes[3]);
        }
        flag1=true;
    }
}

// создание/удаление регистрации
let flag2 = true;
elem[1].childNodes[1].onclick = function(){
    if (flag2){
    createLabel(elem[1], "upName", "Enter name", "text", "[A-Za-zа-яА-ЯёЁ]{2,15}");
    createLabel(elem[1], "upMail", "Enter mail", "email", "no");
    createLabel(elem[1], "upPass", "Enter pass", "password",
                         "(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{6,}");
    createButton(elem[1]);
    flag2 = false;
    }// else - удалить
    else{
        for (i=0;i<4;i++){
            elem[1].childNodes[3].parentNode.removeChild(elem[1].childNodes[3]);
        }
        flag2=true;
    }
}
