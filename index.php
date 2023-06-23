<?php
    require ("dbconnect.php");
    session_start();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>my site</title>
    <link rel="stylesheet" href="css/main.css">
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@700&display=swap"
    rel="stylesheet">
</head>
<body>
 
            
        <?php
            if (empty($_SESSION['auth'])){
                $a = '<div class="up_text font-size-2">sign-></div>';
            }else{
                $file_name = 'img/ava/'.$_SESSION['mail'];
                $image = $_SESSION['avatar'];
                $a = '<div class="up_text font-size-2">'.'Welcome, '.$_SESSION['name'].'</div>';
            }
            include 'header.tpl';
        ?>
    <main>
        <div class="big_text font-size-13">
            Hello
        </div>

        <div class="down_text">
            On this site you can choose a resource
             for learning programming(so far only c++
              and python)
        </div>
        <div class="proglang">
        <div class="python">
            <img src="img/python.png" alt="" class="width100">
            <a href="python.php" class="link">Learn python</a>
        </div>

        <div class="cpp">
            <img src="img/c++.png" alt="" class="width100">
            <a href="c++.php" class="link">Learn C/C++</a>
        </div>
    </div>
    
    </main>

    <?php
        include 'footer.tpl';
    ?>
<script src="script/main.js"></script>
</body>
</html>
