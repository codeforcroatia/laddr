<p>Bok {$User->FirstName},</p>
<p>Dobrodošao u ekspertnu skupinu <a href="http://{$.server.HTTP_HOST}">{$.server.HTTP_HOST}</a>! Čuvaj niže navedene informacije:</p>

<table border="0">
<tr><th align="right">Korisničko ime:</th><td>{$User->Username}</td></tr>
<tr><th align="right">Registriran email:</th><td><a href="mailto:{$User->Email}">{$User->Email}</a></td></tr>
<tr><th align="right">Link za prijavu:</th><td><a href="http://{$.server.HTTP_HOST}/login">http://{$.server.HTTP_HOST}/login</a></td></tr>
</table>

<p>Imaš nekoliko minuta vremena? <a href="http://{$.server.HTTP_HOST}/profile">Postavi sliku i ispuni svoj profil</a></p>
