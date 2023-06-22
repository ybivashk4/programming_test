let theme, flagTheme = true;
let lang, flagLang = true
theme = document.getElementById("theme");
lang = document.getElementsByClassName("lang")[0];
// #5680E9 - #84CEEB - #5AB9EA - #C1C8E4 - #8860D0
const changeTheme = function(){
    if (flagTheme){
        document.body.style.background = "#84CEEB";

        let upText = document.getElementsByClassName("up_text");
        for (i=0;i<upText.length;i++){
            upText[i].style.color = "#8860D0";
        }
        let bigText = document.getElementsByClassName("big_text")[0]
        bigText.style.color = "#8860D0";
        for (i=0;i<3;i++){
        document.getElementsByClassName("down_text")[i].style.color = "#8860D0";
        }
        let img = document.getElementsByClassName("changeImage");
        img[0].src = img[0].src.slice(0, img[0].src.indexOf("menuDark.png")) 
                                                        + "menuLight.png";
        img[1].src = img[1].src.slice(0, img[1].src.indexOf("langDark.png")) 
        + "langLight.png";
        img[2].src = img[2].src.slice(0, img[2].src.indexOf("moonDark.png")) 
        + "sunny.png";
        flagTheme = false;
    }else{
        document.body.style.background = "#202833";
        let upText = document.getElementsByClassName("up_text");
        for (i=0;i<upText.length;i++){
            upText[i].style.color = "#66FCF1";
        }
        document.getElementsByClassName("big_text")[0].style.color = "#66FCF1";
        for (i=0;i<3;i++){
        document.getElementsByClassName("down_text")[i].style.color = "#46A29F";
        }
        let img = document.getElementsByClassName("changeImage");
        img[0].src = img[0].src.slice(0, img[0].src.indexOf("menuLight.png")) 
                                                        + "menuDark.png";
        img[1].src = img[1].src.slice(0, img[1].src.indexOf("langLight.png")) 
        + "langDark.png";
        img[2].src = img[2].src.slice(0, img[2].src.indexOf("sunny.png")) 
        + "moonDark.png";
        flagTheme = true;
    }
}
theme.onclick = changeTheme;

const changeLang = function(){
    let big, down, up;
    let downRus = ["На этом сайте ты выберешь источник для "+
    "изуения программирование (пока что только с++ и пайтон)",
    "Автор: Михаил Бельтюков", "Рад вас видеть"],

    upRus = ["меню", "Пытайся и делай", "РУС"],

    downEn = ["On this site you can choose a resource for learning"+
    " programming(so far only c++ and python)",
    "Made by Mihail Beltyukov", "Thank you for use it"],

    upEn = ["menu", "Try and do", "ENG"]

    big = document.getElementsByClassName("big_text")
    down = document.getElementsByClassName("down_text")
    up = document.getElementsByClassName("up_text")
    if (flagLang){
        big[0].style.fontSize = "200px";
        big[0].textContent = "Привет";
        for (i=0;i<down.length;i++){
            down[i].textContent = downRus[i];
        }
        for (i=0;i<up.length;i++){
            up[i].textContent = upRus[i];
        }
        flagLang = false
    }else{
        big[0].textContent = "Hello";
        big[0].style.fontSize = "256px";
        for (i=0;i<down.length;i++){
            down[i].textContent = downEn[i];
        }
        for (i=0;i<up.length;i++){
            up[i].textContent = upEn[i];
        }
        flagLang = true
    }
}

// lang.onclick = changeLang; не работает
