let theme, flag = true;
theme = document.getElementById("theme");
// #5680E9 - #84CEEB - #5AB9EA - #C1C8E4 - #8860D0
const changeTheme = function(){
    if (flag){
        document.body.style.background = "#84CEEB";
        let upText = document.getElementsByClassName("up_text");
        for (i=0;i<upText.length;i++){
            upText[i].style.color = "#8860D0";
        }
        for (i=0;i<4;i++){
        document.getElementsByClassName("down_text")[i].style.color = "#8860D0";
        }
        let img = document.getElementsByClassName("changeImage");
        
        img[0].src = img[0].src.slice(0, img[0].src.indexOf("menuDark.png")) + "menuLight.png";
        
        img[1].src = img[1].src.slice(0, img[1].src.indexOf("langDark.png")) + "langLight.png";

        img[2].src = img[2].src.slice(0, img[2].src.indexOf("moonDark.png")) + "sunny.png";

        let button = document.querySelectorAll('.but');
        for(i=0;i<button.length;i++){
            button[i].style.background = "#8860D0";
            button[i].style.color = "#66FCF1";
        }
        flag = false;
    }else{
        document.body.style.background = "#202833";
        let upText = document.getElementsByClassName("up_text");
        for (i=0;i<upText.length;i++){
            upText[i].style.color = "#66FCF1";
        }
        for (i=0;i<4;i++){
        document.getElementsByClassName("down_text")[i].style.color = "#46A29F";
        }
        let img = document.getElementsByClassName("changeImage");


        img[0].src = img[0].src.slice(0, img[0].src.indexOf("menuLight.png")) + "menuDark.png";
        
        img[1].src = img[1].src.slice(0, img[1].src.indexOf("langLight.png")) + "langDark.png";

        img[2].src = img[2].src.slice(0, img[2].src.indexOf("sunny.png")) + "moonDark.png";


        let button = document.querySelectorAll('.but');
        for(i=0;i<button.length;i++){
            button[i].style.background = "#66FCF1";
            button[i].style.color = "#202833";
        }
        flag = true;
    }
}
theme.onclick = changeTheme;

function createLabel(elem, name, textLabel, typeOfInput, pattertn){
    let test1 = document.createElement("label"),
    test2 = document.createElement("input");
    test2.type = typeOfInput;
    test2.name = name;
    test2.required = "True";
    if (name == "inMail")
        test2.value = document.getElementById("kostyl").innerHTML;
    else test2.value = "";
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
