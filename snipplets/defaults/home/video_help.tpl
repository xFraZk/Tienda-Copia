{# Video that work as examples #}

<section class="section-video-home px-2 px-md-3" data-store="home-video">
	<div class="container-fluid">
		<div class="row">
			<div class="col">
				<div class="embed-responsive embed-responsive-16by9">
					{{ component('placeholders/video-placeholder',{
						placeholder_classes: {
							svg_class: 'video-image',
						}})
					}}
					{% if not params.preview %}
						<div class="placeholder-overlay transition-soft">
							<div class="placeholder-info">
								{% include "snipplets/svg/edit.tpl" with {svg_custom_class: "icon-inline icon-3x"} %}
								<div class="placeholder-description">
									{{ "Podés subir tu video de YouTube desde" | translate }} <strong>"{{ "Video" | translate }}"</strong>
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
