<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>my site</title>
    <link rel="stylesheet" href="css/main.css">
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@700&display=swap"
    rel="stylesheet">
</head>
<body>
    <main style="align-items: start;">
    <?php
        $n = pg_fetch_array(pg_query(pg_connect("host=localhost dbname=tests user=postgres password=123"), "SELECT COUNT (*) \"Задание\" FROM tst.\"Задания\" WHERE \"id темы\"=1"))[0];
        for ($i = 0; $i < $n; $i+=1) {
            $query = "SELECT \"Задание\" FROM tst.\"Задания\" WHERE \"id темы\"=1 LIMIT 1 OFFSET $i";
            $result = pg_query(pg_connect("host=localhost dbname=tests user=postgres password=123"), $query);
            $table = pg_fetch_array($result);
            $i += 1;
            echo("<div class='down_text'><span class='down_text'>$i.&#160 $table[0]</div>");
            $i -= 1;
        }
    ?>
    </main>
<script src="script/tests.js"></script>
</body>