{# Instagram feed that work as examples #}

<section class="section-instafeed-home px-2 px-md-3" data-store="home-instagram-feed">
	<div class="container-fluid">
		<div class="row justify-content-center">
			<div class="col-md-5">
				<div class="instafeed-card">
					<div class="instafeed-title">
						<h2 class="h2 h1-md mt-2 mb-4">{{ 'Seguinos en Instagram' | translate }}</h2>
					</div>
				</div>
			</div>
			<div class="col-md-7">
				<div id="instafeed" class="row pt-4">
					{% include 'snipplets/defaults/help_instagram.tpl' with {'help_item_1': true} %}
					{% include 'snipplets/defaults/help_instagram.tpl' with {'help_item_2': true} %}
					{% include 'snipplets/defaults/help_instagram.tpl' with {'help_item_1': true} %}
					{% include 'snipplets/defaults/help_instagram.tpl' with {'help_item_2': true} %}
					{% include 'snipplets/defaults/help_instagram.tpl' with {'help_item_1': true} %}
					{% include 'snipplets/defaults/help_instagram.tpl' with {'help_item_2': true} %}
					{% if not params.preview %}
						<div class="placeholder-overlay transition-soft">
							<div class="placeholder-info">
								{% include "snipplets/svg/edit.tpl" with {svg_custom_class: "icon-inline icon-3x"} %}
								<div class="placeholder-description">
									{{ "Podés mostrar tus últimas novedades desde" | translate }} <strong>"{{ "Publicaciones de Instagram" | translate }}"</strong>
								</div>
								<a href="{{ admin_link }}#instatheme=pagina-de-inicio" class="btn btn-secondary btn-small">{{ "Editar" | translate }}</a>
							</div>
						</div>
					{% endif %}
				</div>
			</div>
		</div>
	</div>
</section>