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
        // вход
            if (!empty($_POST['inMail']) and !empty($_POST['inPass'])){
                $mail = $_POST['inMail'];
                $password = $_POST['inPass'];
                $query = " SELECT \"имя\" FROM tst.\"Пользователь\" WHERE \"почта\"='$mail' and \"пароль\" = '$password'";
                $res = pg_query(pg_connect("host=localhost dbname=tests user=postgres password=123"), $query);
                
                $user = pg_fetch_array($res);
                
                if (!empty($user)){
                    $_SESSION['auth'] = true;
                    $_SESSION['name'] = $user[0];
                    $_SESSION['mail'] = $mail;
                    $a = '<div class="up_text font-size-2">Welcome </div>';
                }else{
                    $a = '<div class="up_text font-size-2">Wrong input </div>';
                }
            }else if (empty($_SESSION['auth'])){
                $a = '<div class="up_text font-size-2">sign in/up</div>'; 
            }else{
                $a = '<div class="up_text font-size-2">Welcome </div>';
            }
            
        // регестрация
        if (!empty($_POST['upMail']) and !empty($_POST['upPass']) and !empty($_POST['upName'])){
            $mail = $_POST['upMail'];
            $password = $_POST['upPass'];
            $name = $_POST['upName'];
            $query = "SELECT \"tst\".add_user_func('$mail', '$password', '$name')"; // добавление записи в таблицу
            $flag = pg_query(pg_connect("host=localhost dbname=tests user=postgres password=123"), $query);
            $flag = pg_fetch_array($flag)[0];
            // Если успешно - вернёт 1, иначе 0 (если запись уже есть)
            if (!$flag){ 
                $a = '<div class="up_text font-size-2">sign in</div>';
            }else{
                $_SESSION['auth'] = true;
                $_SESSION['name'] = $name;
                $_SESSION['mail'] = $mail;
                $a = '<div class="up_text font-size-2">Welcome </div>';
            }
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
            if (empty($_SESSION['auth'])){
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
                $uploaddir = null;
                $file_name = null;
                $_SESSION['avatar'] = null;
                $_SESSION['mail'];
                header('Location: form.php');
            }
            ?>

            <?php
            if (!isset($_FILES['image']['name']) and !empty($_SESSION['auth'])){
                echo ' <form method="POST" enctype="multipart/form-data" style="margin-top:1em;">
                <input type="file" style="color:#46A29F;margin-left:15%" name="image" accept="image/*" required>
                <input type="submit" style="margin-left: 25%" class="but" value="set avatar"> 
                </form>';
            }
            ?>
            
            <?php if (isset($_FILES['image']['name']) and !empty($_SESSION['auth'])){
                $uploaddir = '/domains/prtest/img/ava/';
                $file_name = 'img/ava/' . $_SESSION['mail'];
                $uploadfile = $uploaddir . $_SESSION['mail'];
                move_uploaded_file($_FILES['image']['tmp_name'], $uploadfile);
                $_SESSION['avatar'] = "<img src=\"$file_name\" class='height-3 width-3'  alt=\"\">";
            } 
            ?>
            <?php if (!empty($_SESSION['auth'])){
                $file_name = 'img/ava/'.$_SESSION['mail'];
                $_SESSION['avatar'] = "<img src=\"$file_name\" class='height-3 width-3' ' alt=\"\">";
                //echo $_SESSION['avatar'];
            }   
            ?>
    </main>

    <?php
        include 'footer.tpl';
    ?>

    <script src="script/form.js"></script>
</body>
</html>
<!-- admin@admin.admin Aasd123-->

