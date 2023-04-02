<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>my site</title>
    <link rel="stylesheet" href="css/main.css">
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@700&display=swap"
    rel="stylesheet">
</head>
<body>
        <?php
            if ($_POST["inMail"] != "" || $_POST["upMail"] != "")
                $a = '<div class="up_text">Welcome</div>';
            else
                $a = '<div class="up_text">sign pls</div>';
                include 'header.tpl';
            
                
        ?>
    <main>
        <div class="big_text">
            Hello
        </div>

        <div class="down_text" id="note">
            On this site you can choose a resource
             for learning programming(so far only c++
              and python)
        </div>
        <div class="proglang">
        <div class="python">
            <img src="img/python.png" alt="">
            <a href="python.php" class="link">Learn python</a>
        </div>

        <div class="cpp">
            <img src="img/c++.png" alt="">
            <a href="c++.php" class="link">Learn C/C++</a>
        </div>
    </div>
    
    </main>

    <?php
        include 'footer.tpl';
    ?>
</body>
</html>
