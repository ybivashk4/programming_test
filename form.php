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
        include 'header.tpl';
    ?>

    <main>
        <div>
            <div class="up_text">
                <a href="index.php" class="up_text">Back</a>
            </div>
            <br>

        <div>
            <form method="POST" action="index.php">
                <div class="down_text">
                    <span class="up_text">Sign in</span>
                </div>
            </form>

            <br>

            <form method="POST" action="index.php">
                <div class="down_text">
                    <div>
                        <span class="up_text">Sign up</span>
                    </div>
                </div>
            </form>
        </div>

    </main>

    <?php
        include 'footer.tpl';
    ?>

    <script src="script/form.js"></script>
</body>
</html>