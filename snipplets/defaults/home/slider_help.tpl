{# Slider that work as example #}

<div class="section-slider">
	<div class="js-home-empty-slider nube-slider-home swiper-container swiper-container-horizontal">
		<div class="swiper-wrapper">
			{% for i in 1..3 %}
				<div class="swiper-slide slide-container">
					<div class="slider-slide">
						{{ component('placeholders/banner-placeholder',{
							placeholder_classes: {
								svg_class: 'slider-image',
							}})
						}}
					</div>
				</div>
			{% endfor %}
		</div>
		{% if not params.preview %}
			<div class="placeholder-overlay transition-soft">
				<div class="placeholder-info">
					{% include "snipplets/svg/edit.tpl" with {svg_custom_class: "icon-inline icon-3x"} %}
					<div class="placeholder-description">
						{{ "Podés subir imágenes principales desde" | translate }} <strong>"{{ "Carrusel de imágenes" | translate }}"</strong>
					</div>
					<a href="{{ admin_link }}#instatheme=pagina-de-inicio" class="btn btn-secondary btn-small">{{ "Editar" | translate }}</a>
				</div>
			</div>
		{% endif %}
		<div class="js-swiper-empty-home-pagination swiper-pagination swiper-pagination-bullets swiper-pagination-white"></div>
	</div>
</div>