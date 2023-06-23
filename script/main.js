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


