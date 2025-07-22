{# Informative banners that work as examples #}

<section class="section-informative-banners px-2 px-md-3" data-store="banner-services">
	<div class="container-fluid">
		<div class="row">
			{% include 'snipplets/defaults/help_banner_services_item.tpl' with {'help_item_1': true} %}
			{% include 'snipplets/defaults/help_banner_services_item.tpl' with {'help_item_2': true} %}
			{% include 'snipplets/defaults/help_banner_services_item.tpl' with {'help_item_3': true} %}
		</div>
	</div>
	{% if not params.preview %}
		<div class="placeholder-overlay transition-soft">
			<div class="placeholder-info">
				{% include "snipplets/svg/edit.tpl" with {svg_custom_class: "icon-inline icon-3x"} %}
				<div class="placeholder-description">
					{{ "Podés mostrar tu información para la compra desde" | translate }} <strong>"{{ "Información de envíos, pagos y compra" | translate }}"</strong>
				</div>
				<a href="{{ admin_link }}#instatheme=pagina-de-inicio" class="btn btn-secondary btn-small">{{ "Editar" | translate }}</a>
			</div>
		</div>
	{% endif %}
</section>