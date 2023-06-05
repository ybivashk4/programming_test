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
            if ($_GET["inMail"] != "" && $_GET["inPass"] != ""){
                echo "<div class =\"up_text\"> Welcome, admin </div>";
            }
                include 'header.tpl';
        ?>

    <main class="flex-row-nowrap">
        <div>
            <div class="up_text">
                <a href="index.php" class="up_text font-size-max-3 font-size-2">Back</a>
            </div>

        </div>

        <div class="up_text font-size-2 font-size-max-2">
             c++ knowledge test
        </div>

        <form method="POST" action="#" id="form_test">
            <input class="big_but" type="submit" value="Start test">
        </form>
    </main>

    <?php
        include 'footer.tpl';
    ?>
<script src="script/main.js"></script>
</body>
</html>