<div class="col-6 col-md-4">
	<div class="instafeed-link mb-4">
		<div class="instafeed-img p-0">
			{% set type_value = help_item_1 ? 'like_icon' : 'instagram_icon' %}
			{{ component('placeholders/instagram-post-placeholder',{type: type_value})}}
		</div>
	</div>
</div>