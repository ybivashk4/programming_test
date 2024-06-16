<?php
    require ("dbconnect.php");
    session_start(["use_strict_mode" => true]);
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
    <?php
    if (isset($_GET['page'])) {
        switch ($_GET['page']) {
            case 'cpp':
                include 'c++.php';
                break;
            case 'python':
                include 'python.php';
                break;
            case 'form':
                include 'form.php';
                break;
            case 'py_test':
                include 'py_test.php';
                break;
            case 'c_test':
                include 'c_test.php';
                break;
        }
    }
    else {
        include 'start_page.php'; 
    }

    
    ?>
    </main>

    <?php
        include 'footer.tpl';
    ?>
<script src="script/main1.js"></script>
</body>
</html>
