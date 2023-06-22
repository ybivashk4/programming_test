<?php
require ("dbconnect.php");
session_start();

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/main.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@700&display=swap"
    rel="stylesheet">
    <title>Document</title>
</head>
<body>
    
        <?php
            if (!empty($_POST['inMail']) and !empty($_POST['inPass'])){
                $mail = $_POST['inMail'];
                $password = $_POST['inPass'];
                $query = " SELECT \"имя\" FROM tst.\"Пользователь\" WHERE \"почта\"='$mail' and \"пароль\" = '$password'";
                $res = pg_query(pg_connect("host=localhost dbname=tests user=postgres password=123"), $query);
                
                $user = pg_fetch_array($res);
                
                if (!empty($user)){
                    $_SESSION['auth'] = true;
                    $_SESSION['name'] = $user[0];
                    $a = '<div class="up_text font-size-2">Welcome </div>';
                }else{
                    $a = '<div class="up_text font-size-2">Wrong input </div>';
                }
            }else if (!$_SESSION['auth']){
                $a = '<div class="up_text font-size-2">sign in/up</div>'; 
            }else{
                $a = '<div class="up_text font-size-2">Welcome </div>';
            }
            include 'header.tpl';   
        ?>

    <main>
        <div>
            <div class="up_text">
                <a href="index.php" class="up_text font-size-max-3 font-size-2">Back</a>
            </div>

        </div>
            <?php
            if (!$_SESSION['auth']){
                echo '<form method="POST">
                    <div class="down_text flex-column-wrap">
                        <span class="up_text">Sign in</span>
                    </div>
                </form>';

                echo '<form method="POST">
                    <div class="down_text flex-column-wrap">
                        <div>
                            <span class="up_text">Sign up</span>
                        </div>
                    </div>
                </form>';
            }else{
                echo '<form method="POST"> <input class="but height-5" type="submit" value="exit" name="exit"> </form>';
                echo '<div class="down_text"> for back to main page click "back". </div>';
                echo '<div class="down_text"> for sign out ckick "exit". </div>';
            }
            if (!empty($_POST['exit'])){
                $_SESSION['auth'] = null;
                header('Location: form.php');
            }
            ?>
    </main>

    <?php
        include 'footer.tpl';
        echo empty($_SESSION['auth']);
    ?>

    <script src="script/form.js"></script>
</body>
</html>
<!-- admin@admin.admin Aasd123-->

