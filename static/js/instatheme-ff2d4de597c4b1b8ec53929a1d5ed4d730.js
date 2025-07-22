window.tiendaNubeInstaTheme = (function($) {
	return {
		waitFor: function() {
			return [window.homeSlider];
		},
		handlers: function(instaElements) {
			return {
				logo: new instaElements.Logo({
					$storeName: $('#no-logo'),
					$logo: $('#logo')
				}),
				// ----- Section order -----
				home_order_position: new instaElements.Sections({
					container: '.js-home-sections-container',
					data_store: {
						'slider': 'home-slider',
						'banners': 'home-banner-categories',
						'products': 'home-products-featured',
						'brands': 'home-brands',
						'category': 'home-products-category',
						'video': 'home-video',
						'informatives': 'banner-services',
						'sale': 'home-products-sale',
						'instafeed': 'home-instagram-feed',
					}
				}),
				slider: new instaElements.GenericSlider(window.homeSlider),
				slider_auto: new instaElements.AutoSliderCheckbox({
					slider: 'slider'
				})
			};
		}
	};
})(jQuery);