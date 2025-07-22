{# Banners that work as examples #}

<section class="section-banners-home pl-2 px-md-3" data-store="home-banner-categories">
	<div class="container-fluid">
		<div class="row align-items-center">
			<div class="js-swiper-banners-demo swiper-container">
				<div class="swiper-wrapper">
					{% for i in 1..3 %}
						<div class="col-md swiper-slide">
							<div class="textbanner">
								<div class="textbanner-image overlay">
									{{ component('placeholders/banner-placeholder',{
										placeholder_classes: {
											svg_class: 'textbanner-image-background',
										}})
									}}
									<div class="textbanner-text">
										<div class="h1">{{ "Categoría" | translate }}</div>
									</div>
								</div>
							</div>
						</div>
					{% endfor %}
				</div>
			</div>
		</div>
		{% if not params.preview %}
			<div class="placeholder-overlay placeholder-overlay-invert transition-soft">
				<div class="placeholder-info">
					{% include "snipplets/svg/edit.tpl" with {svg_custom_class: "icon-inline icon-3x"} %}
					<div class="placeholder-description">
						{{ "Podés destacar categorías de tu tienda desde" | translate }} <strong>"{{ "Banners de categorías" | translate }}"</strong>
					</div>
					<a href="{{ admin_link }}#instatheme=pagina-de-inicio" class="btn btn-secondary btn-small">{{ "Editar" | translate }}</a>
				</div>
			</div>
		{% endif %}
	</div>
</section>