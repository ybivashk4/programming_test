<?php
    require ("dbconnect.php");
    session_start();
?>
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
        <div>
            <div class="up_text">
                <a href="index.php" class="up_text font-size-max-3 font-size-2">Back</a>
            </div>

        </div>

        <div class="up_text font-size-2">
             py knowledge test
        </div>

        <form method="POST" action="#" id="form_test" style="margin-right: 2%;">
            <input class="big_but" type="submit" value="Start test">
        </form>
    </main>

    <?php
        include 'footer.tpl';
    ?>
<script src="script/tests.js"></script>
</body>
</html>