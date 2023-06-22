<?php
    
    require ("dbconnect.php");
    session_start();
    if (!empty($_POST['inMail']) and !empty($_POST['inPass'])){
        $mail = $_POST['inMail'];
        echo '<div class="up_text">arbuz </div>';
        $password = $_POST['inPass'];
        $query = " SELECT \"почта\", \"пароль\" FROM tst.\"Пользователь\" WHERE \"почта\"='$mail' and \"пароль\" = '$password' ";
        $res = pg_query($conn, $query);
        $user = pg_fetch_assoc($res);
        if (!empty($user)){
            $_SESSION['auth'] = true;
            echo '<div class="up_text">arbuz </div>';
        }else{
            echo '<div class="up_text">arbuz </div>';
        }
    }else{
        echo '<div class="up_text">arbuz </div>';
    }
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
            $a = '<div class="up_text font-size-2">Welcome</div>';
            include 'header.tpl';   
        ?>

    <main class="flex-row-nowrap">
        <div>
            <div class="up_text">
                <a href="index.php" class="up_text font-size-max-3 font-size-2">Back</a>
            </div>

        </div>

            <form method="POST" action="index.php">
                <div class="down_text flex-column-wrap">
                    <span class="up_text">Sign in</span>
                </div>
            </form>

            <form method="POST" action="index.php">
                <div class="down_text flex-column-wrap">
                    <div>
                        <span class="up_text">Sign up</span>
                    </div>
                </div>
            </form>

    </main>

    <?php
        include 'footer.tpl';
        echo empty($_SESSION['auth']);
    ?>

    <script src="script/form.js"></script>
</body>
</html>
<!-- admin@admin.admin 123-->