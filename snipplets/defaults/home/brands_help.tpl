{# Brands that work as examples #}

<section class="section-brands-home px-2 px-md-3" data-store="home-brands">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-6">
				<div class="h1 mb-4">{{ 'Marcas' | translate }}</div>
			</div>
			<div class="col-md-6">
				<div class="js-swiper-brands-demo swiper-container mb-4 text-center">
					<div class="swiper-wrapper">
						{% for i in 1..6 %}
							<div class="swiper-slide slide-container brand-image-container">
								{{ component('placeholders/brand-placeholder' , {
									placeholder_classes: {
										svg_class: 'brand-image svg-icon-invert',
									}})
								}}
							</div>
						{% endfor %}
					</div>
				</div>
			</div>
		</div>
		{% if not params.preview %}
			<div class="placeholder-overlay transition-soft">
				<div class="placeholder-info">
					{% include "snipplets/svg/edit.tpl" with {svg_custom_class: "icon-inline icon-3x"} %}
					<div class="placeholder-description">
						{{ "Podés subir logos de tus marcas desde" | translate }} <strong>"{{ "Marcas" | translate }}"</strong>
					</div>
					<a href="{{ admin_link }}#instatheme=pagina-de-inicio" class="btn btn-secondary btn-small">{{ "Editar" | translate }}</a>
				</div>
			</div>
		{% endif %}
	</div>
</section>
