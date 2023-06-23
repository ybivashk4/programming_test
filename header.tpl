<header>
    <?php
    if (isset($image)){
        echo $image;
    }

    if (isset($a))
         echo $a; 
    ?>
    <div class="menu">
        <img src="img/menuDark.png" alt="" class="changeImage width50">
        <a href="form.php" class="up_text font-size-2"> form </a>
    </div>

    <div class="up_text font-size-2" id="TaD">
        Try and do
    </div>

    <div class="lang">
        <img src="img/langDark.png" alt="" class="changeImage">
        <span class="up_text font-size-2" id="two_up">EN</span>
    </div>

    <img src="img/moonDark.png" alt="" id="theme" class="changeImage">
</header>