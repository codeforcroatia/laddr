{extends "designs/site.tpl"}


{block "content"}
<div id="app-body">

	{$User = $data}
	
	<h1>{$.server.HTTP_HOST} članstvo je zaprimljeno</h1>
	<hr class="clear" />
	
	<p>Tvoje korisničko ime je: <a href="/people/{$User->Username}">{$User->Username|escape}</a></p>
	
	<p>
		Što učiniti dalje&hellip;
		<ul>
			{if $.request.return}
			<li><a href="{$.request.return|escape}">Vrati se na {$.request.return|escape}</a></li>
			{/if}
			<li><a href="/profile">Ispuni svoj profil i postavi profilnu sliku</a></li>
		</ul>
	</p>
</div>	
{/block}
