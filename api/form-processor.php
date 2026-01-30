<?php
if ($_SERVER["REQUEST_METHOD"] === "POST") {
  if (isset($_POST['action']) && $_POST['action'] === 'subscribe') {
    $email = $_POST["email"];
    $subject = "Subscribe to Nova Energy Invest"; 
    $to = "info@novaenergyinvest.co.za"; // 
    $headers = "From: $email\r\n";
    $headers .= "Reply-To: $email\r\n";
    $headers .= "Content-type: text/html\r\n";
    $message = "Subscribe Email " . $email;

    $messageBody = "Email: $email<br>Message: $message";

    if (mail($to, $subject, $messageBody, $headers)) {
      echo "success";
    } else {
      echo "error";
    }
  } elseif (isset($_POST['action']) && $_POST['action'] === 'contact-full') {
    // New full contact form
    $name = $_POST['name'];
    $email = $_POST["email"];
    $subject = $_POST["subject"];
    $phone = $_POST["phone"];
    $message = $_POST["message"];

    $to = "info@novaenergyinvest.co.za"; 
    $headers = "From: $email\r\n";
    $headers .= "Reply-To: $email\r\n";
    $headers .= "Content-type: text/html\r\n";

    $messageBody = "
      <strong>Name:</strong> $name<br>
      <strong>Email:</strong> $email<br>
      <strong>Subject:</strong> $subject<br>
      <strong>Phone:</strong> $phone<br>
      <strong>Message:</strong><br>$message
    ";

    if (mail($to, $subject, $messageBody, $headers)) {
      echo "success";
    } else {
      echo "error";
    }
  } 
}
