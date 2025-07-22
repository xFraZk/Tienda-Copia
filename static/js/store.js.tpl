{#/*============================================================================
    #Specific store JS functions: product variants, cart, shipping, etc
==============================================================================*/#}

{#/*============================================================================
  
  Table of Contents

    #Lazy load
    #Notificactions
    #Modals
    #Tabs
    #Cards
    #Header and nav
        // Nav
        // Search suggestions
    #Sliders
        // Home slider
        // Banner services slider
    #Social
        // Youtube or Vimeo video
        // Facebook login
    #Product grid
        // Filters
        // Sort by
        // Infinite scroll
    #Product detail functions
        // Installments
        // Change Variant
        // Product labels on variant change
        // Color and size variants change
        // Custom mobile variants change
        // Submit to contact
        // Product slider
        // Pinterest sharing
        // Product quantity
    #Cart
        // Toggle cart 
        // Add to cart
        // Toggle cart totals
        // Cart quantitiy changes
        // Empty cart alert
        // Go to checkout
    #Shipping calculator
        // Cart shipping cost
        // Select and save shipping function
        // Calculate shipping function
        // Calculate shipping by submit
        // Shipping and branch click
        // Select shipping first option on results
        // Toggle branches link
        // Toggle more shipping options
        // Calculate shipping on page load
        // Shipping provinces
        // Change store country
    #Forms
    #Footer
    #Empty placeholders

==============================================================================*/#}

{#/*============================================================================
  #Lazy load
==============================================================================*/ #}

document.addEventListener('lazybeforeunveil', function(e){
    if ((e.target.parentElement) && (e.target.nextElementSibling)) {
        var parent = e.target.parentElement;
        var sibling = e.target.nextElementSibling;
        if (sibling.classList.contains('js-lazy-loading-preloader')) {
            sibling.style.display = 'none';
            parent.style.display = 'block';
        }
    }
});


window.lazySizesConfig = window.lazySizesConfig || {};
lazySizesConfig.hFac = 0.4;


$(document).ready(function(){

    {#/*============================================================================
      #Notifications
    ==============================================================================*/ #}

    {# Notifications variables #}

    var $notification_status_page = $(".js-notification-status-page");
    var $fixed_bottom_button = $(".js-btn-fixed-bottom");

    {# /* // Close notification */ #}

    $(".js-notification-close").on( "click", function(e) {
        e.preventDefault();
        $(this).closest(".js-notification").hide();
    });

    {# /* // Follow order status notification */ #}

    if ($notification_status_page.size() > 0){
        if (LS.shouldShowOrderStatusNotification($notification_status_page.data('url'))){
            $notification_status_page.css("top" , "80px");
            $notification_status_page.show();
        };
        $(".js-notification-status-page-close").on( "click", function(e) {
            e.preventDefault();
            LS.dontShowOrderStatusNotificationAgain($notification_status_page.data('url'));
        });
    }

    {# /* // Cart notification: Dismiss notification */ #}

    $(".js-cart-notification-close").click(function(){
        $(".js-alert-added-to-cart").removeClass("notification-visible").addClass("notification-hidden");
        setTimeout(function(){
            $('.js-cart-notification-item-img').attr('src', '');
            $(".js-alert-added-to-cart").hide();
        },2000);
    });

    {% if not params.preview %}
        
        {# /* // Cookie banner notification */ #}

        restoreNotifications = function(){

            // Whatsapp button position
            if ($(window).width() < 768) {
                $fixed_bottom_button.css({"margin-bottom": "0"});
            }
        };

        if (!window.cookieNotificationService.isAcknowledged()) {
            $(".js-notification-cookie-banner").show();

            {# Whatsapp button position #}
            if ($(window).width() < 768) {
                $fixed_bottom_button.css({"margin-bottom": "110px"});
            }
        }

        $(".js-acknowledge-cookies").on( "click", function(e) {
            window.cookieNotificationService.acknowledge();
            restoreNotifications();
        });

    {% endif %}

    {#/*============================================================================
      #Modals
    ==============================================================================*/ #}

    {% if settings.quick_shop %}

        restoreQuickshopForm = function(){

            {# Restore form to item when quickshop closes #}

            {# Clean quickshop modal #}

            $("#quickshop-modal .js-item-product").removeClass("js-swiper-slide-visible js-item-slide");
            $("#quickshop-modal .js-quickshop-container").attr( { 'data-variants' : '' , 'data-quickshop-id': '' } );
            $("#quickshop-modal .js-item-product").attr('data-product-id', '');

            {# Wait for modal to become invisible before removing form #}
            
            setTimeout(function(){
                var $quickshop_form = $("#quickshop-form").find('.js-product-form');
                var $item_form_container = $(".js-quickshop-opened").find(".js-item-variants");
                
                $quickshop_form.detach().appendTo($item_form_container);
                $(".js-quickshop-opened").removeClass("js-quickshop-opened");
            },350);

        };

    {% endif %}
    
    {# Full screen mobile modals back events #}

    if ($(window).width() < 768) {

        {# Clean url hash function #}

        cleanURLHash = function(){
            const uri = window.location.toString();
            const clean_uri = uri.substring(0, uri.indexOf("#"));
            window.history.replaceState({}, document.title, clean_uri);
        };

        {# Go back 1 step on browser history #}

        goBackBrowser = function(){
            cleanURLHash();
            history.back();
        };

        {# Clean url hash on page load: All modals should be closed on load #}

        if(window.location.href.indexOf("modal-fullscreen") > -1) {
            cleanURLHash();
        }

        {# Open full screen modal and url hash #}

        $(document).on("click", ".js-fullscreen-modal-open", function(e) {
            e.preventDefault();
            var modal_url_hash = $(this).data("modal-url");            
            window.location.hash = modal_url_hash;
        });

        {# Close full screen modal: Remove url hash #}

        $(document).on("click", ".js-fullscreen-modal-close", function(e) {
            e.preventDefault();
            goBackBrowser();
        });

        {# Hide panels or modals on browser backbutton #}

        window.onhashchange = function() {
            if(window.location.href.indexOf("modal-fullscreen") <= -1) {

                {# Close opened modal #}

                if($(".js-fullscreen-modal").hasClass("modal-show")){

                    {# Remove body lock only if a single modal is visible on screen #}

                    if($(".js-modal.modal-show").length == 1){
                        $("body").removeClass("overflow-hidden");
                    }

                    var $opened_modal = $(".js-fullscreen-modal.modal-show");
                    var $opened_modal_overlay = $opened_modal.prev();

                    $opened_modal.removeClass("modal-show").delay(500).hide(0);
                    $opened_modal_overlay.fadeOut(500);
            
                    {% if settings.quick_shop %}
                        restoreQuickshopForm();
                    {% endif %}
                }
            }
        }

    }

    modalOpen = function(modal_id){
        var $overlay_id = $('.js-modal-overlay[data-modal-id="' + modal_id + '"]');
        if ($(modal_id).hasClass("modal-show")) {
            $(modal_id).removeClass("modal-show").delay(500).hide(0);
        } else {
            {# Lock body scroll if there is no modal visible on screen #}
            
            if(!$(".js-modal.modal-show").length){
                $("body").addClass("overflow-hidden");
            }
            $overlay_id.fadeIn(400);
            $(modal_id).detach().appendTo("body");
            $overlay_id.detach().insertBefore(modal_id);
            $(modal_id).show(0).addClass("modal-show");
        }    

    };
    
    $(document).on("click", ".js-modal-open", function(e) {
        e.preventDefault(); 
        var modal_id = $(this).data('toggle');
        modalOpen(modal_id);          
    });

    closeModal = function(element){

        {# Remove body lock only if a single modal is visible on screen #}

        if($(".js-modal.modal-show").length == 1){
            $("body").removeClass("overflow-hidden");
        }

        var $modal = $('body .js-modal.modal-show:last-child');
        var $overlay = $modal.prev(".js-modal-overlay");
        $modal.removeClass("modal-show").delay(500).hide(0); 
        $overlay.fadeOut(500);

        {# Close full screen modal: Remove url hash #}

        if (($(window).width() < 768) && ($(element).hasClass(".js-fullscreen-modal-close"))) {
            goBackBrowser();
        }

        {% if settings.quick_shop %}
            restoreQuickshopForm();
        {% endif %}
        
    };

    $(document).on("click", ".js-hamburger-open", function(e) {
        e.preventDefault();
        $(this).toggleClass("js-modal-close js-modal-open js-hamburger-close hamburger-close");
        $(this).closest(".js-head-main").toggleClass("head-transparent head-z-index");
        $(this).closest(".js-head-main").find(".utilities-item:not(.js-hamburger-menu)").toggle();
    });

    $(document).on("click", ".js-hamburger-close", function(e) {
        e.preventDefault();
        $(".js-menu-panel").fadeOut(300);
    });

    $(document).on("click", ".js-modal-close", function(e) {
        e.preventDefault();
        closeModal($(this));
    });

    {# Close modal on ESC keyboard #}

    $(document).keyup(function(e) {
        if (e.keyCode == 27) {
            closeModal($(".js-modal-close"));    
        }
    });

    $(document).on("click", ".js-modal-overlay", function(e) {
        e.preventDefault();  

        {# Remove body lock only if a single modal is visible on screen #}
        
        if($(".js-modal.modal-show").length == 1){
            $("body").removeClass("overflow-hidden");
        }

        var modal_id = $(this).data('modal-id');
        $(modal_id).removeClass("modal-show").delay(500).hide(0);   
        $(this).fadeOut(500);   

        {% if settings.quick_shop %}
            restoreQuickshopForm();
        {% endif %}

        if ($(this).hasClass("js-fullscreen-overlay") && $(window).width() < 768) {
            cleanURLHash();
        }
    });

     {# /* Open cart after add to cart recommendations dismiss */ #}

    jQueryNuvem(".js-open-cart-modal").on("click", function (e) {
        setTimeout(function(){
            modalOpen('#modal-cart');
        },300);
    });

    {#/*============================================================================
      #Tabs
    ==============================================================================*/ #}

    {% if (template == 'home' and settings.category_products_url) or template == 'account.orders'  %}
        $('.js-tab-nav a').on('click', function (event) {
            event.preventDefault();
            $('.tab-active').removeClass('tab-active');
            $(this).parent().addClass('tab-active');
            $('.js-tab-stage').fadeOut(200);
            $($(this).attr('href')).delay(150).fadeIn(200);
        });

        $('.js-tab-nav a:first').trigger('click'); // Default
    {% endif %}

    {#/*============================================================================
      #Cards
    ==============================================================================*/ #}
    $(document).on("click", ".js-card-collapse-toggle", function(e) {
        e.preventDefault();
        $(this).toggleClass('active');
        $(this).closest(".js-card-collapse").toggleClass('active');
    });

    {#/*============================================================================
      #Header and nav
    ==============================================================================*/ #}

    {# /* // Header */ #}

    {# /* // Nav offset */ #}

    {% if settings.ad_bar and settings.ad_text %}

        var head_height = $(".js-advertising-bar").innerHeight();
        $(".js-head-offset").css("padding-top", head_height);
        if ($(window).width() < 768) {
            $(".js-sidebar-content").css("top", head_height);
        }

    {% endif %}

    {# /* // Nav */ #}

    {# Nav subitems #}

    $(".js-toggle-menu-panel").click(function (e) {
        e.preventDefault();
        $(this).next(".js-menu-panel").fadeIn(300);
    });

    $(".js-toggle-menu-back").click(function (e) {
        e.preventDefault();
        $(this).closest(".js-menu-panel").fadeOut(300);
    });

    $(".js-toggle-menu-close").click(function (e) {
        e.preventDefault();
        $(".js-menu-panel").fadeOut(300);
    });

    {# Focus search #}

    $(document).on("click", ".js-toggle-search", function(e) {
        e.preventDefault();
        $(".js-search-input").focus();
    });

    {# /* // Search suggestions */ #}

        LS.search($(".js-search-input"), function (html, count) {
            $search_suggests = $(this).closest(".js-search-container").next(".js-search-suggest");
            if (count > 0) {
                $search_suggests.html(html).show();
            } else {
                $search_suggests.hide();
            }
            if (!$(this).val()) {
                $search_suggests.hide();
            }
        }, {
            snipplet: 'header/header-search-results.tpl'
        });

        if ($(window).width() > 768) {

            {# Hide search suggestions if user click outside results #}

            $("body").click(function () {
                $(".js-search-suggest").hide();
            });

            {# Maintain search suggestions visibility if user click on links inside #}

            $(document).on("click", ".js-search-suggest a", function () {
                $(".js-search-suggest").show();
            });
        }

        $(".js-search-suggest").on("click", ".js-search-suggest-all-link", function (e) {
            e.preventDefault();
            $this_closest_form = $(this).closest(".js-search-suggest").prev(".js-search-form");
            $this_closest_form.submit();
        });


    {#/*============================================================================
      #Sliders
    ==============================================================================*/ #}

    {% if template == 'home' %}

        {# /* // Home slider */ #}

        var width = window.innerWidth;
        if (width > 767) {  
            var slider_autoplay = {delay: 6000,};
        } else {
            var slider_autoplay = false;
        }

        window.homeSlider = {
            getAutoRotation: function() {
                return slider_autoplay;
            },
            updateSlides: function(slides) {
                homeSwiper.removeAllSlides();
                slides.forEach(function(aSlide){
                    homeSwiper.appendSlide(
                        '<div class="swiper-slide slide-container">' +
                            (aSlide.link ? '<a href="' + aSlide.link + '">' : '' ) +
                                '<img src="' + aSlide.src + '" class="slider-image"/>' +
                                '<div class="swiper-text swiper-' + aSlide.color + '">' +
                                    (aSlide.title ? '<div class="swiper-title">' + aSlide.title + '</div>' : '' ) +
                                    (aSlide.description ? '<div class="swiper-description mb-3">' + aSlide.description + '</div>' : '' ) +
                                    (aSlide.button && aSlide.link ? '<div class="btn btn-primary d-inline-block mt-3">' + aSlide.button + '</div>' : '' ) +
                                '</div>' +
                            (aSlide.link ? '</a>' : '' ) +
                        '</div>'
                    );
                });
                if(!slides.length){
                    $(".js-home-main-slider-container").addClass("hidden");
                    $(".js-home-empty-slider-container").removeClass("hidden");
                    $(".js-home-mobile-slider-visibility").removeClass("d-md-none");
                    {% if has_mobile_slider %}
                        $(".js-home-main-slider-visibility").removeClass("d-none d-md-block");
                        homeMobileSwiper.update();
                    {% endif %}
                }else{
                    $(".js-home-main-slider-container").removeClass("hidden");
                    $(".js-home-empty-slider-container").addClass("hidden");
                    $(".js-home-mobile-slider-visibility").addClass("d-md-none");
                    {% if has_mobile_slider %}
                        $(".js-home-main-slider-visibility").addClass("d-none d-md-block");
                    {% endif %}
                }
            },
            changeAutoRotation: function(){

            },
        };

        var preloadImagesValue = false;
        var lazyValue = true;
        var loopValue = true;
        var watchOverflowValue = true;
        var paginationClickableValue = true;

        var homeSwiper = null;
        createSwiper(
            '.js-home-slider',
            {
                lazy: lazyValue,
                preloadImages: preloadImagesValue,
                {% if settings.slider | length > 1 %}
                    loop: loopValue,
                {% endif %}
                autoplay: slider_autoplay,
                watchOverflow: watchOverflowValue,
                pagination: {
                    el: '.js-swiper-home-pagination',
                    clickable: paginationClickableValue,
                },
                navigation: {
                    nextEl: '.js-swiper-home-next',
                    prevEl: '.js-swiper-home-prev',
                },
            },
            function (swiperInstance) {
                homeSwiper = swiperInstance;
            }
        );

        var homeMobileSwiper = null;
        createSwiper(
            '.js-home-slider-mobile',
            {
                lazy: lazyValue,
                preloadImages: preloadImagesValue,
                {% if settings.slider | length > 1 %}
                    loop: loopValue,
                {% endif %}
                autoplay: slider_autoplay,
                watchOverflow: watchOverflowValue,
                pagination: {
                    el: '.js-swiper-home-pagination-mobile',
                    clickable: paginationClickableValue,
                },
                navigation: {
                    nextEl: '.js-swiper-home-next-mobile',
                    prevEl: '.js-swiper-home-prev-mobile',
                },
            },
            function(swiperInstance) {
                homeMobileSwiper = swiperInstance;
            }
        );

        {% if settings.slider | length == 1 %}
            $('.js-swiper-home .swiper-wrapper').addClass( "disabled" );
            $('.js-swiper-home-pagination, .js-swiper-home-prev, .js-swiper-home-next').remove();
        {% endif %}

        {# /* // Banners slider */ #}

        createSwiper('.js-swiper-banners', {
            lazy: true,
            watchOverflow: true,
            slidesPerView: 1.2,
            breakpoints: {
                768: {
                    slidesPerView: 3,
                }
            }
        });

        {# /* // Brands slider */ #}

        {% if settings.brands and settings.brands is not empty %}

            createSwiper('.js-swiper-brands', {
                lazy: true,
                watchOverflow: true,
                centerInsufficientSlides: true,
                slidesPerView: 2,
                slidesPerColumn: 3,
                pagination: {
                    el: '.js-swiper-brands-pagination',
                    clickable: true,
                },
                navigation: {
                    nextEl: '.js-swiper-brands-next',
                    prevEl: '.js-swiper-brands-prev',
                },
                breakpoints: {
                    768: {
                        slidesPerView: 3,
                        slidesPerColumn: 2,
                    }
                }
            });

        {% endif %}

        {# /* // Products slider */ #}

        {% set columns = settings.grid_columns %}

        {% if sections.primary.products or sections.sale.products or settings.category_products_url %}

            {% if settings.product_color_variants or settings.quick_shop %}

                {# Duplicate cloned slide elements for quickshop or colors forms #}

                updateClonedItemsIDs = function(element){
                    $(element).each(function() {
                        var $this = $(this);
                        var slide_index = $this.attr("data-swiper-slide-index");
                        var clone_quick_id = $this.find(".js-quickshop-container").attr("data-quickshop-id");
                        var clone_product_id = $this.attr("data-product-id");
                        $this.attr("data-product-id" , clone_product_id + "-clone-" + slide_index);
                        $this.find(".js-quickshop-container").attr("data-quickshop-id" , clone_quick_id + "-clone-" + slide_index);
                    });
                };

            {% endif %}

            var lazyVal = true;
            var watchOverflowVal = true;
            var slidesPerViewDesktopVal = {% if columns == 1 %}2{% elseif columns == 2 %}3{% else %}4{% endif %};
            var slidesPerViewMobileVal = 1.5;

            {% if sections.primary.products %}

                createSwiper('.js-swiper-featured', {
                    lazy: lazyVal,
                    watchOverflow: watchOverflowVal,
                    threshold: 5,
                    watchSlideProgress: true,
                    watchSlidesVisibility: true,
                    slideVisibleClass: 'js-swiper-slide-visible',
                    pagination: {
                        el: '.js-swiper-featured-pagination',
                        clickable: true,
                    },
                    navigation: {
                        nextEl: '.js-swiper-featured-next',
                        prevEl: '.js-swiper-featured-prev',
                    },
                    spaceBetween: 10,
                    slidesPerView: 1,
                    slidesPerColumn: 3,
                    slidesPerColumnFill: 'row',
                    {% if settings.product_color_variants or settings.quick_shop %}
                        on: {
                            init: function () {
                                updateClonedItemsIDs(".js-swiper-featured .js-item-slide.swiper-slide-duplicate");
                            },
                        }
                    {% endif %}
                });

            {% endif %}

            {% if sections.sale.products %}

                createSwiper('.js-swiper-sale', {
                    lazy: lazyVal,
                    watchOverflow: watchOverflowVal,
                    {% if sections.sale.products | length > 3 %}
                        loop: true,
                    {% endif %}
                    threshold: 5,
                    watchSlideProgress: true,
                    watchSlidesVisibility: true,
                    slideVisibleClass: 'js-swiper-slide-visible',
                    navigation: {
                        nextEl: '.js-swiper-sale-next',
                        prevEl: '.js-swiper-sale-prev',
                    },
                    spaceBetween: 20,
                    slidesPerView: slidesPerViewMobileVal,
                    breakpoints: {
                        768: {
                            slidesPerView: slidesPerViewDesktopVal,
                        }
                    },
                    {% if settings.product_color_variants or settings.quick_shop %}
                        on: {
                            init: function () {
                                updateClonedItemsIDs(".js-swiper-sale .js-item-slide.swiper-slide-duplicate");
                            },
                        }
                    {% endif %}
                });

            {% endif %}

            {% if settings.category_products_url %}
                {# /* // Category products slider without subcategories level */ #}
                {% block categorySwiper %}
                    createSwiper('.js-swiper-category{{ loop.index }}', {
                        lazy: lazyVal,
                        watchOverflow: watchOverflowVal,
                        threshold: 5,
                        navigation: {
                            nextEl: '.js-swiper-category{{ loop.index }}-next',
                            prevEl: '.js-swiper-category{{ loop.index }}-prev',
                        },
                        spaceBetween: 20,
                        slidesPerView: slidesPerViewMobileVal,
                        breakpoints: {
                            768: {
                                slidesPerView: slidesPerViewDesktopVal,
                            }
                        }
                    });
                {% endblock %}
                {% for category in categories %}
                    {% if category.url == settings.category_products_url %}
                        {% if category.subcategories %}
                            {# /* // Category products slider with subcategories level */ #}
                            {% for subcategory in category.subcategories %}
                                {{ block('categorySwiper') }}
                            {% endfor %}
                        {% endif %}
                    {% endif %}
                    {% for subcategory in category.subcategories %}
                        {% if subcategory.url == settings.category_products_url %}
                            {% if subcategory.subcategories %}
                                {# /* // Category products slider with subsubcategories level */ #}
                                {% for subsubcategory in subcategory.subcategories %}
                                    {{ block('categorySwiper') }}
                                {% endfor %}
                            {% endif %}
                        {% endif %}
                        {% for subsubcategory in subcategory.subcategories %}
                            {% if subsubcategory.url == settings.category_products_url %}
                                {% if subsubcategory.subcategories %}
                                    {# /* // Category products slider with subsubsubcategories level */ #}
                                    {% for subsubsubcategory in subsubcategory.subcategories %}
                                        {{ block('categorySwiper') }}
                                    {% endfor %}
                                {% endif %}
                            {% endif %}
                        {% endfor %}
                    {% endfor %}
                {% endfor %}
            {% endif %}

        {% endif %}

    {% endif %}

    {% if template == 'product' %}

        {# /* // Fixed add to cart form */ #}
        
        if ($(window).width() < 768) {

            var $fixed_product_form = $('.js-fixed-product-form');
            var $fixed_product_form_placeholder = $(".js-fixed-product-form-placeholder");
            var distance = $(".js-product-detail-bottom").offset().top;
            var product_form_height = $(".js-fixed-product-form").height();
            
            $fixed_product_form_placeholder.height(product_form_height - 5);

            $('.js-product-form-toggle').hide();

            $(window).scroll(function () {
                if ($(window).scrollTop() >= distance) {
                    $fixed_product_form_placeholder.show();
                    $fixed_product_form.addClass("fixed-product-form");
                    $fixed_product_form.find(".js-product-variants:not(.product-variants-show)").hide();
                    $('.js-product-form-toggle').show();
                    {% if not product.variations %}
                        $fixed_product_form.find(".js-product-without-variants").hide();
                    {% endif %}
                } else {
                    $fixed_product_form_placeholder.hide();
                    $fixed_product_form.removeClass("fixed-product-form");
                    $fixed_product_form.find('.js-product-variants').show();
                    $('.js-product-form-toggle').hide();
                    {% if not product.variations %}
                        $fixed_product_form.find(".js-product-without-variants").show();
                    {% endif %}
                }
            });

            $(document).on("click", ".js-product-detail-back", function(e) {
                e.preventDefault();
                goBackBrowser();
            });

            {% if product.variations %}
                $('.js-product-form-toggle').click(function(e){
                    e.preventDefault();
                    $(this).next('.js-product-variants').slideToggle();
                    $(this).next('.js-product-variants').toggleClass('product-variants-show');
                    $(".js-product-form-toggle-icon").toggle();
                });
            {% endif %}
        }

        {# /* // Product description toggle */ #}

        {% if product.description is not empty %}
            if ($('.js-product-description').height() < $('.js-product-description')[0].scrollHeight){
                $(".js-view-description").show();
            }

            $(document).on("click", ".js-view-description", function(e) {
                e.preventDefault();
                $(this).closest(".js-product-description").toggleClass("product-description-full");
                $(".js-view-more, .js-view-less").toggle();
            });
        {% endif %}

        {# /* // Product Related */ #}

        // Set loop for related products products sliders

        {% set columns = settings.grid_columns %}
        const desktopColumns = {% if columns == 1 %}2{% elseif columns == 2 %}3{% else %}4{% endif %};

        {# Alternative products #}

        createSwiper('.js-swiper-related', {
            watchOverflow: true,
            threshold: 5,
            watchSlideProgress: true,
            watchSlidesVisibility: true,
            navigation: {
                nextEl: '.js-swiper-related-next',
                prevEl: '.js-swiper-related-prev',
            },
            spaceBetween: 20,
            slidesPerView: 1.5,
            breakpoints: {
                768: {
                    slidesPerView: desktopColumns,
                }
            }
        });

        {# Complementary products #}

        createSwiper('.js-swiper-complementary', {
            watchOverflow: true,
            threshold: 5,
            watchSlideProgress: true,
            watchSlidesVisibility: true,
            navigation: {
                nextEl: '.js-swiper-complementary-next',
                prevEl: '.js-swiper-complementary-prev',
            },
            spaceBetween: 20,
            slidesPerView: 1.5,
            breakpoints: {
                768: {
                    slidesPerView: desktopColumns,
                }
            }
        });

    {% endif %}


    {#/*============================================================================
      #Social
    ==============================================================================*/ #}

    {% if template == 'home' %}
        {% set video_url = settings.video_embed %}
    {% elseif template == 'product' and product.video_url %}
        {% set video_url = product.video_url %}
    {% endif %}

    {% if video_url %}

        {# /* // Youtube or Vimeo video for home or each product */ #}

        LS.loadVideo('{{ video_url }}');
        
    {% endif %}

    {#/*============================================================================
      #Product grid
    ==============================================================================*/ #}

    var mobile_nav_height = $(".js-head-main").outerHeight();

    {% if template == 'category' %}

        {# /* // Filters */ #}

        $(document).on("click", ".js-apply-filter, .js-remove-filter", function(e) {
            e.preventDefault();
            var filter_name = $(this).data('filter-name');
            var filter_value = $(this).data('filter-value');
            if($(this).hasClass("js-apply-filter")){
                $(this).find("[type=checkbox]").prop("checked", true);
                LS.urlAddParam(
                    filter_name, 
                    filter_value, 
                    true
                );
            }else{
                $(this).find("[type=checkbox]").prop("checked", false);
                LS.urlRemoveParam(
                    filter_name, 
                    filter_value
                );   
            }
            {# Toggle class to avoid adding double parameters in case of double click and show applying changes feedback #}

            if ($(this).hasClass("js-filter-checkbox")){
                if ($(window).width() < 768) {
                    $(".js-filters-overlay").show();
                    if($(this).hasClass("js-apply-filter")){
                        $(".js-applying-filter").show();
                    }else{
                        $(".js-removing-filter").show();
                    }
                }
                $(this).toggleClass("js-apply-filter js-remove-filter");
            }
        });

        $(document).on("click", ".js-remove-all-filters", function(e) {
            e.preventDefault();
            LS.urlRemoveAllParams();
        });

        {# /* //  Accordions */ #}

        $(document).on("click", ".js-accordion-toggle", function(e) {
            e.preventDefault();
            if($(this).hasClass("js-accordion-show-only")){
                $(this).hide();
            }else{
                $(this).find(".js-accordion-toggle-inactive").toggle();
                $(this).find(".js-accordion-toggle-active").toggle();
            }
            if($(this).hasClass("js-accordion-show-next")){
                $(this).prev(".js-accordion-container").slideToggle();
            }else{
                $(this).prev(".js-accordion-container").slideToggle();
            }
        });

        {# /* // Sort by */ #}

        $('.js-sort-by').change(function () {
            var params = LS.urlParams;
            params['sort_by'] = $(this).val();
            var sort_params_array = [];
            for (var key in params) {
                if ($.inArray(key, ['results_only', 'page']) == -1) {
                    sort_params_array.push(key + '=' + params[key]);
                }
            }
            var sort_params = sort_params_array.join('&');
            window.location = window.location.pathname + '?' + sort_params;
        });

    {% endif %}

    {% set has_item_slider = settings.product_item_slider %}

    {% if template == 'category' or template == 'search' %}

        {# /* // Product item slider */ #}

        {% if has_item_slider %}

            LS.productItemSlider({ 
                pagination_type: 'fraction',
            });

        {% endif %}

        $(function() {

            {# /* // Infinite scroll */ #}

            {% if pages.current == 1 and not pages.is_last %}
                LS.hybridScroll({
                    productGridSelector: '.js-product-table',
                    spinnerSelector: '#js-infinite-scroll-spinner',
                    loadMoreButtonSelector: '.js-load-more',
                    hideWhileScrollingSelector: ".js-hide-footer-while-scrolling",
                    productsBeforeLoadMoreButton: 50,
                    productsPerPage: 12,
                    afterLoaded: function(){                        
                        {% if has_item_slider %}
                            LS.productItemSlider({ 
                                pagination_type: 'fraction',
                            });
                        {% endif %}
                    },
                });
            {% endif %}
        });

    {% endif %}

    {# /* // Variants without stock */ #}

    {% set is_button_variant = template == 'product' and (settings.bullet_variants or settings.image_color_variants) %}

    {% if is_button_variant %}
        const noStockVariants = (container = null) => {

            {# Configuration for variant elements #}
            const config = {
                variantsGroup: ".js-product-variants-group",
                variantButton: ".js-insta-variant",
                noStockClass: "btn-variant-no-stock",
                dataVariationId: "data-variation-id",
                dataOption: "data-option"
            };

            {# Product container wrapper #}
            const wrapper = container ? container : $('#single-product');
            if (!wrapper) return;

            {# Fetch the variants data from the container #}
            const dataVariants = wrapper.data('variants');
            const variantsLength = wrapper.find(config.variantsGroup).length;

            {# Get selected options from product variations #}
            const getOptions = (productVariationId, variantOption) => {
                if (productVariationId === 2) {
                    return {
                        option0: String(wrapper.find(`${config.variantsGroup}[${config.dataVariationId}="0"] select`).val()),
                        option1: String(wrapper.find(`${config.variantsGroup}[${config.dataVariationId}="1"] select`).val()),
                        option2: String($(variantOption).attr('data-option')),
                    };
                } else if (productVariationId === 1) {
                    return {
                        option0: String(wrapper.find(`${config.variantsGroup}[${config.dataVariationId}="0"] select`).val()),
                        option1: String($(variantOption).attr('data-option')),
                    };
                } else {
                    return {
                        option0: String($(variantOption).attr('data-option')),
                    };
                }
            };

            {# Filter available variants based on selected options #}
            const filterVariants = (options) => {
                return dataVariants.filter(variant => {
                    return Object.keys(options).every(optionKey => variant[optionKey] === options[optionKey]) && variant.available;
                });
            };

            {# Update stock status for variant buttons #}
            const updateStockStatus = (productVariationId) => {
                const variationGroup = wrapper.find(`${config.variantsGroup}[${config.dataVariationId}="${productVariationId}"]`);
                variationGroup.find(`${config.variantButton}.${config.noStockClass}`).removeClass(config.noStockClass);

                variationGroup.find(config.variantButton).each((index, item) => {
                    const options = getOptions(productVariationId, item);
                    const itemsAvailable = filterVariants(options);
                    const button = wrapper.find(`${config.variantsGroup}[${config.dataVariationId}="${productVariationId}"] ${config.variantButton}[${config.dataOption}="${options[`option${productVariationId}`].replace(/"/g, '\\"')}"]`);

                    if (!itemsAvailable.length) {
                        button.addClass(config.noStockClass);
                    }
                });
            };

            {# Iterate through all variant and update stock status #}
            for (let productVariationId = variantsLength - 1; productVariationId >= 0; productVariationId--) {
                updateStockStatus(productVariationId);
            }
        };

        noStockVariants();

    {% endif %}

    {#/*============================================================================
      #Product detail functions
    ==============================================================================*/ #}

    {# /* // Installments */ #}

    {# Installments without interest #}

    function get_max_installments_without_interests(number_of_installment, installment_data, max_installments_without_interests) {
        if (parseInt(number_of_installment) > parseInt(max_installments_without_interests[0])) {
            if (installment_data.without_interests) {
                return [number_of_installment, installment_data.installment_value.toFixed(2)];
            }
        }
        return max_installments_without_interests;
    }

    {# Installments with interest #}

    function get_max_installments_with_interests(number_of_installment, installment_data, max_installments_with_interests) {
        if (parseInt(number_of_installment) > parseInt(max_installments_with_interests[0])) {
            if (installment_data.without_interests == false) {
                return [number_of_installment, installment_data.installment_value.toFixed(2)];
            }
        }
        return max_installments_with_interests;
    }

    {# Updates installments on payment popup for native integrations #}

    function refreshInstallmentv2(price){
        $(".js-modal-installment-price" ).each(function( index ) {
            const installment = Number($(this).data('installment'));
            $(this).text(LS.currency.display_short + (price/installment).toLocaleString('de-DE', {maximumFractionDigits: 2, minimumFractionDigits: 2}));
        });
    }

    {# Refresh price on payments popup with payment discount applied #}

    function refreshPaymentDiscount(price){
        $(".js-price-with-discount" ).each(function( index ) {
            const payment_discount = $(this).data('payment-discount');
            $(this).text(LS.formatToCurrency(price - ((price * payment_discount) / 100)))
        });
    }

    {% set should_show_discount = product.maxPaymentDiscount.value > 0 %}
    {% if should_show_discount %}

        {# Shows/hides price with discount and strikethrough original price for every payment method #}

        function togglePaymentDiscounts(variant){
            $(".js-payment-method-total").each(function( _index, paymentMethodTotalElement ){
                const priceComparerElement = $(paymentMethodTotalElement).find(".js-compare-price-display");
                const installmentsOnePaymentElement = $(paymentMethodTotalElement).find('.js-installments-no-discount');
                const priceWithDiscountElement = $(paymentMethodTotalElement).find('.js-price-with-discount');

                priceComparerElement.hide();
                installmentsOnePaymentElement.hide();
                priceWithDiscountElement.hide();

                const discount = priceWithDiscountElement.data('paymentDiscount');

                if (discount > 0 && showMaxPaymentDiscount(variant)){
                    priceComparerElement.show();
                    priceWithDiscountElement.show()
                } else {
                    installmentsOnePaymentElement.show();
                }
            })
        }

        {# Toggle discount and discount disclaimer both on product details and popup #}

        function updateDiscountDisclaimers(variant){
            updateProductDiscountDisclaimer(variant);
            updatePopupDiscountDisclaimers(variant);
        }

        {# Toggle discount and discount disclaimer in product details #}

        function updateProductDiscountDisclaimer(variant){
            $(".js-product-discount-container, .js-product-discount-disclaimer").hide();

            if (showMaxPaymentDiscount(variant)){
                $(".js-product-discount-container").show();
            }

            if (showMaxPaymentDiscountNotCombinableDisclaimer(variant)){
                $(".js-product-discount-disclaimer").show();
            }
        }

        {# Shows/hides discount message for payment method and discount disclaimer in popup, for every payment method #}

        function updatePopupDiscountDisclaimers(variant){
            $(".js-modal-tab-discount, .js-payment-method-discount").hide();

            {% if product.maxPaymentDiscount.value > 0 %}
                if (showMaxPaymentDiscount(variant)){
                    {% for key, method in product.payment_methods_config %}
                        {% if method.max_discount > 0 %}
                            {% if method.allows_discount_combination %}
                                $("#method_{{ key | sanitize }} .js-modal-tab-discount").show();
                            {% elseif not product.free_shipping %}
                                if (!variantHasPromotionalPrice(variant)){
                                    $("#method_{{ key | sanitize }} .js-modal-tab-discount").show();
                                }
                            {% endif %}
                        {% endif %}
                    {% endfor %}
                }
            {% endif %}

            $(".js-info-payment-method-container").each(function( _index, infoPaymentMethodElement){
                {# For each payment method this will show the payment method discount and discount explanation #}

                const infoPaymentMethod = $(infoPaymentMethodElement)
                infoPaymentMethod.find(".js-discount-explanation").hide();
                infoPaymentMethod.find(".js-discount-disclaimer").hide();

                const priceWithDiscountElement = infoPaymentMethod.find('.js-price-with-discount');
                const discount = priceWithDiscountElement.data('paymentDiscount');

                if (discount > 0 && showMaxPaymentDiscount(variant)){
                    infoPaymentMethod.find(".js-discount-explanation").show();
                    infoPaymentMethod.find(".js-payment-method-discount").show();
                }

                if (discount > 0 && showMaxPaymentDiscountNotCombinableDisclaimer(variant)){
                    infoPaymentMethod.find(".js-discount-disclaimer").show();
                }
            })
        }

        function variantHasPromotionalPrice(variant) { return variant.compare_at_price_number > variant.price_number }

        function showMaxPaymentDiscount(variant) {
            {% if product.maxPaymentDiscount()["allowsDiscountCombination"] %}
                return true;
            {% elseif product.free_shipping %}
                return false;
            {% else %}
                return !variantHasPromotionalPrice(variant);
            {% endif %}
        }

        function showMaxPaymentDiscountNotCombinableDisclaimer(variant) {
            {% if product.maxPaymentDiscount()["allowsDiscountCombination"] or product.free_shipping %}
                return false
            {% else %}
                return !variantHasPromotionalPrice(variant)
            {% endif %}
        }

    {% endif %}

    {# /* // Change variant */ #}

    {# Updates price, installments, labels and CTA on variant change #}

    function changeVariant(variant){

        $(".js-product-detail .js-shipping-calculator-response").hide();
        $("#shipping-variant-id").val(variant.id);

        var parent = $("body");
        if (variant.element){
            parent = $(variant.element);
        }

        {% if is_button_variant %}
            {# Updates variants without stock #}
            noStockVariants();
        {% endif %}

        var sku = parent.find('#sku');
        if(sku.length) {
            sku.text(variant.sku).show();
        }

        {# Updates installments on list item and inside payment popup for Payments Apps #}

        var installment_helper = function($element, amount, price){
            $element.find('.js-installment-amount').text(amount);
            $element.find('.js-installment-price').attr("data-value", price);
            $element.find('.js-installment-price').text(LS.currency.display_short + parseFloat(price).toLocaleString('de-DE', { minimumFractionDigits: 2 }));
            if(variant.price_short && Math.abs(variant.price_number - price * amount) < 1) {
                $element.find('.js-installment-total-price').text((variant.price_short).toLocaleString('de-DE', { minimumFractionDigits: 2 }));
            } else {
                $element.find('.js-installment-total-price').text(LS.currency.display_short + (price * amount).toLocaleString('de-DE', { minimumFractionDigits: 2 }));
            }
        };

        if (variant.installments_data) {
            var variant_installments = JSON.parse(variant.installments_data);
            var max_installments_without_interests = [0,0];
            var max_installments_with_interests = [0,0];

            {# Hide all installments rows on payments modal #}
            $('.js-payment-provider-installments-row').hide();

            $.each(variant_installments, function(payment_method, installments) {

                {# Identifies the minimum installment value #}
                var paymentMethodId = '#installment_' + payment_method.replace(" ", "_") + '_1';
                var minimumInstallmentValue = $(paymentMethodId).closest('.js-info-payment-method').attr("data-minimum-installment-value");

                $.each(installments, function(number_of_installment, installment_data) {
                    max_installments_without_interests = get_max_installments_without_interests(number_of_installment, installment_data, max_installments_without_interests);
                    max_installments_with_interests = get_max_installments_with_interests(number_of_installment, installment_data, max_installments_with_interests);
                    var installment_container_selector = '#installment_' + payment_method.replace(" ", "_") + '_' + number_of_installment;

                    {# Shows installments rows on payments modal according to the minimum value #}
                    if(minimumInstallmentValue <= installment_data.installment_value) {
                        $(installment_container_selector).show();
                    }

                    if(!parent.hasClass("js-quickshop-container")){
                        installment_helper($(installment_container_selector), number_of_installment, installment_data.installment_value.toFixed(2));
                    }
                });
            });
            var $installments_container = $(variant.element + ' .js-max-installments-container .js-max-installments');
            var $installments_modal_link = $(variant.element + ' #btn-installments');
            var $payments_module = $(variant.element + ' .js-product-payments-container');
            var $installmens_card_icon = $(variant.element + ' .js-installments-credit-card-icon');

            {% if product.has_direct_payment_only %}
            var installments_to_use = max_installments_without_interests[0] >= 1 ? max_installments_without_interests : max_installments_with_interests;

            if(installments_to_use[0] <= 0 ) {
            {%  else %}
            var installments_to_use = max_installments_without_interests[0] > 1 ? max_installments_without_interests : max_installments_with_interests;

            if(installments_to_use[0] <= 1 ) {
            {% endif %}
                $installments_container.hide();
                $installments_modal_link.hide();
                $payments_module.hide();
                $installmens_card_icon.hide();
            } else {
                $installments_container.show();
                $installments_modal_link.show();
                $payments_module.show();
                $installmens_card_icon.show();
                installment_helper($installments_container, installments_to_use[0], installments_to_use[1]);
            }
        }

        if(!parent.hasClass("js-quickshop-container")){
            $('#installments-modal .js-installments-one-payment').text(variant.price_short).attr("data-value", variant.price_number);
        }
        
        if (variant.price_short){
            parent.find('.js-price-display').text(variant.price_short).show();
            parent.find('.js-price-display').attr("content", variant.price_number).data('productPrice', variant.price_number_raw);

            parent.find('.js-payment-discount-price-product').text(variant.price_with_payment_discount_short);
            parent.find('.js-payment-discount-price-product-container').show();
            
            parent.find('.js-price-without-taxes').text(variant.price_without_taxes);
            parent.find('.js-price-without-taxes-container').show();
        } else {
            parent.find('.js-price-display, .js-payment-discount-price-product-container, .js-price-without-taxes-container').hide();
        }

        if ((variant.compare_at_price_short) && !(parent.find(".js-price-display").css("display") == "none")) {
            parent.find('.js-compare-price-display').text(variant.compare_at_price_short).show();
        } else {
            parent.find('.js-compare-price-display').hide();
        }

        var button = parent.find('.js-addtocart');
        button.removeClass('cart').removeClass('contact').removeClass('nostock');
        var $product_shipping_calculator = parent.find("#product-shipping-container");
        {% if not store.is_catalog %}
        if (!variant.available){
            button.val('{{ "Sin stock" | translate }}');
            button.addClass('nostock');
            button.attr('disabled', 'disabled');
            $product_shipping_calculator.hide();
        } else if (variant.contact) {
            button.val('{{ "Consultar precio" | translate }}');
            button.addClass('contact');
            button.removeAttr('disabled');
            $product_shipping_calculator.hide();
        } else {
            button.val('{{ "Agregar al carrito" | translate }}');
            button.addClass('cart');
            button.removeAttr('disabled');
            $product_shipping_calculator.show();
        }

        {% endif %}

        {% if template == 'product' %}
            const base_price = Number($("#price_display").attr("content"));
            refreshInstallmentv2(base_price);
            refreshPaymentDiscount(variant.price_number);
            {% if should_show_discount %}
                togglePaymentDiscounts(variant);
                updateDiscountDisclaimers(variant);
            {% endif %}

            {% if settings.last_product and product.variations %}
                if(variant.stock == 1) {
                    $('.js-last-product').show();
                } else {
                    $('.js-last-product').hide();
                }
            {% endif %}
        {% endif %}

        {# Update shipping on variant change #}

        LS.updateShippingProduct();

        {% if cart.free_shipping.min_price_free_shipping.min_price %}
            
            {# Updates free shipping bar #}

            LS.freeShippingProgress(true, parent);

        {% endif %}

        zipcode_on_changevariant = $("#product-shipping-container .js-shipping-input").val();
        $("#product-shipping-container .js-shipping-calculator-current-zip").text(zipcode_on_changevariant);
    }

    {# /* // Product labels on variant change */ #}

    {# Stock, Offer and discount labels update #}

    $(document).on("change", ".js-variation-option", function(e) {

        var $parent = $(this).closest(".js-product-variants");
        var $variants_group = $(this).closest(".js-product-variants-group");
        var $quickshop_parent_wrapper = $(this).closest(".js-quickshop-container");

        {# If quickshop is used from modal, use quickshop-id from the item that opened it #}
        
        var quick_id = $quickshop_parent_wrapper.attr("data-quickshop-id");

        if($parent.hasClass("js-product-quickshop-variants")){

            var $quickshop_parent = $(this).closest(".js-item-product");

            {# Target visible slider item if necessary #}
            
            if($quickshop_parent.hasClass("js-item-slide")){
                var $quickshop_variant_selector = '.js-swiper-slide-visible .js-quickshop-container[data-quickshop-id="'+quick_id+'"]';
            }else{
                var $quickshop_variant_selector = '.js-quickshop-container[data-quickshop-id="'+quick_id+'"]';
            }
            
            LS.changeVariant(changeVariant, $quickshop_variant_selector);

            {% if settings.product_color_variants %}
                {# Match selected color variant with selected quickshop variant #}

                if(($variants_group).hasClass("js-color-variants-container")){
                    var selected_option_id = $(this).find("option:selected").val();
                    if($quickshop_parent.hasClass("js-item-slide")){
                        var $color_parent_to_update = $('.js-swiper-slide-visible .js-quickshop-container[data-quickshop-id="'+quick_id+'"]');
                    }else{
                        var $color_parent_to_update = $('.js-quickshop-container[data-quickshop-id="'+quick_id+'"]');
                    }
                    $color_parent_to_update.find('.js-color-variant').removeClass("selected");
                    $color_parent_to_update.find('.js-color-variant[data-option="'+selected_option_id+'"]').addClass("selected");
                }
            {% endif %} 
        } else {
            LS.changeVariant(changeVariant, '#single-product');
        }

        {# Offer and discount labels update #}

        var $this_product_container = $(this).closest(".js-product-container");

        if($this_product_container.hasClass("js-quickshop-container")){
            var this_quickshop_id = $this_product_container.attr("data-quickshop-id");
            var $this_product_container = $('.js-product-container[data-quickshop-id="'+this_quickshop_id+'"]');
        }
        var $this_compare_price = $this_product_container.find(".js-compare-price-display");
        var $this_price = $this_product_container.find(".js-price-display");
        var $installment_container = $this_product_container.find(".js-product-payments-container");
        var $installment_text = $this_product_container.find(".js-max-installments-container");
        var $this_add_to_cart = $this_product_container.find(".js-prod-submit-form");

        // Get the current product discount percentage value
        var current_percentage_value = $this_product_container.find(".js-offer-percentage");

        // Get the current product price and promotional price
        var compare_price_value = $this_compare_price.html();
        var price_value = $this_price.html();

        // Calculate new discount percentage based on difference between filtered old and new prices
        const percentageDifference = window.moneyDifferenceCalculator.percentageDifferenceFromString(compare_price_value, price_value);
        if(percentageDifference){
            $this_product_container.find(".js-offer-percentage").text(percentageDifference);
            $this_product_container.find(".js-offer-label").css("display" , "table");
        }

        if ($this_compare_price.css("display") == "none" || !percentageDifference) {
            $this_product_container.find(".js-offer-label").hide();
        }
        if ($this_add_to_cart.hasClass("nostock")) {
            $this_product_container.find(".js-stock-label").show();
        }
        else {
            $this_product_container.find(".js-stock-label").hide();
        }
        if ($this_price.css('display') == 'none'){
            $installment_container.hide();
            $installment_text.hide();
        }else{
            $installment_text.show();
        }
    });

    {% if settings.product_color_variants %}

        {# Product color variations #}

        $(document).on("click", ".js-color-variant", function(e) {
            e.preventDefault();
            $this = $(this);

            var option_id = $this.data('option');
            $selected_option = $this.closest('.js-item-product').find('.js-variation-option option').filter(function() {
                return this.value == option_id;
            });
            $selected_option.prop('selected', true).trigger('change');
            var available_variant = $(this).closest(".js-quickshop-container").data('variants');

            var available_variant_color = $(this).closest('.js-color-variant-active').data('option');

            for (var variant in available_variant) {
                if (option_id == available_variant[variant]['option'+ available_variant_color ]) {

                    if (available_variant[variant]['stock'] == null || available_variant[variant]['stock'] > 0 ) {

                        var otherOptions = getOtherOptionNumbers(available_variant_color);

                        var otherOption = available_variant[variant]['option' + otherOptions[0]];
                        var anotherOption = available_variant[variant]['option' + otherOptions[1]];

                        changeSelect($(this), otherOption, otherOptions[0]);
                        changeSelect($(this), anotherOption, otherOptions[1]);
                        break;

                    }
                }
            }
            $this.siblings().removeClass("selected");
            $this.addClass("selected");
        });

        function getOtherOptionNumbers(selectedOption) {
            switch (selectedOption) {
                case 0:
                    return [1, 2];
                case 1:
                    return [0, 2];
                case 2:
                    return [0, 1];
            }
        }

        function changeSelect(element, optionToSelect, optionIndex) {
            if (optionToSelect != null) {
                var selected_option_parent_id = element.closest('.js-item-product').data("product-id");
                var selected_option_attribute = $('.js-item-product[data-product-id="'+selected_option_parent_id+'"]').find('.js-color-variant-available-' + (optionIndex + 1)).data('value');
                var selected_option = $('.js-item-product[data-product-id="'+selected_option_parent_id+'"]').find('.js-variation-option[data-variant-id="'+selected_option_attribute+'"] option').filter(function() {
                    return this.value == optionToSelect;
                });

                selected_option.prop('selected', true).trigger('change');
            }
        }

    {% endif %}

    {% if is_button_variant %}
        changeVariantButton = function(selector, parentSelector) {
            selector.siblings().removeClass("selected");
            selector.addClass("selected");
            var option_id = selector.attr('data-option');
            var parent = selector.closest(parentSelector);
            var selected_option = parent.find('.js-variation-option option').filter(function() {
                return this.value == option_id;
            });
            selected_option.prop('selected', true).trigger('change');
            parent.find('.js-insta-variation-label').html(option_id);
        }

        {# /* // Color and size variations */ #}

        $(document).on("click", ".js-insta-variant", function (e) {
            e.preventDefault();
            $this = $(this);
            changeVariantButton($this, '.js-product-variants-group');
        });

    {% endif %}

    {% if settings.product_color_variants or settings.quick_shop %}
    
        {# Product quickshop for color variations #}

        LS.registerOnChangeVariant(function(variant){
            {# Show product image on color change #}
            
            const productContainer = $('.js-item-product[data-product-id="'+variant.product_id+'"]');
            var $item_to_update_image = $('.js-item-product[data-product-id^="'+variant.product_id+'"].js-swiper-slide-visible');
            var $item_to_update_image_cloned = $('.js-item-product[data-product-id^="'+variant.product_id+'"].js-swiper-slide-visible.swiper-slide-duplicate');

            {# If item is cloned from swiper change only cloned item #}

            if($item_to_update_image.hasClass("swiper-slide-duplicate")){
                var slide_item_index = $item_to_update_image_cloned.attr("data-swiper-slide-index");
                var current_image = $('.js-item-image', '.js-item-product[data-product-id="'+variant.product_id+'-clone-'+slide_item_index+'" ]');
            }else{
                var slide_item_index = $item_to_update_image.attr("data-swiper-slide-index");
                var current_image = $('.js-item-image', '.js-item-product[data-product-id="'+variant.product_id+'"]');
            }
            current_image.attr('srcset', variant.image_url);

            {% if has_item_slider %}

                {# Remove slider when variant changes #}

                const swiperElement = productContainer.find('.js-product-item-slider-container-private.swiper-container-initialized');

                if(swiperElement.length){
                    productContainer.find('.js-product-item-slider-slide-private').removeClass('item-image-slide');
                    setTimeout(function(){
                        const productImageLink = productContainer.find('.js-product-item-image-link-private');
                        const imageToKeep = productContainer.find('.js-swiper-slide-visible img').clone();
                        
                        // Destroy the Swiper instance
                        if (itemProductSliders[variant.product_id]) {
                            itemProductSliders[variant.product_id].destroy(true, true);
                            delete itemProductSliders[variant.product_id];
                        }
                        // Remove the Swiper elements
                        swiperElement.remove();
                        productContainer.find('.js-product-item-slider-pagination-container-private').remove();

                        // Insert the cloned image into the link
                        productImageLink.append(imageToKeep);

                    },300);
                }
            {% endif %}

            {% if settings.product_hover %}
                {# Remove secondary feature on image updated from changeVariant #}
                productContainer.find(".js-product-item-private-with-secondary-images").addClass("product-item-secondary-images-disabled");
            {% endif %}
        });

        
    {% endif %}

    {% if settings.quick_shop %}
        
        $(document).on("click", ".js-quickshop-modal-open", function (e) {
            e.preventDefault();
            var $this = $(this);
            if($this.hasClass("js-quickshop-slide")){
                $("#quickshop-modal .js-item-product").addClass("js-swiper-slide-visible js-item-slide");
            }
            LS.fillQuickshop($this);
        });

    {% endif %}

    {# /* // Submit to contact */ #}

    {# Submit to contact form when product has no price #}

    $(".js-product-form").submit(function (e) {
        var button = $(this).find(':submit');
        button.attr('disabled', 'disabled');
        if ((button.hasClass('contact')) || (button.hasClass('catalog'))) {
            e.preventDefault();
            var product_id = $(this).find("input[name='add_to_cart']").val();
            window.location = "{{ store.contact_url | escape('js') }}?product=" + product_id;
        } else if (button.hasClass('cart')) {
            button.val('{{ "Agregando..." | translate }}');
        }
    });

    {% if template == 'product' %}

        {# /* // Product slider */ #}

            {% set has_multiple_slides = product.images_count > 1 or video_url %}

            function productSliderNav(){
                var productSwiper = null;
                createSwiper(
                    '.js-swiper-product',
                    {
                        lazy: true,
                        loop: false,
                        pagination: {
                            el: '.js-swiper-product-pagination',
                            type: 'fraction',
                            clickable: true,
                        },
                        on: {
                            init: function () {
                              $(".js-product-slider-placeholder").hide();
                              $(".js-swiper-product").css({"visibility" : "visible" , "height" : "auto"});
                                {% if video_url %}
                                    productSwiperHeight = $(".js-swiper-product").height();
                                    $(".js-product-video-slide").height(productSwiperHeight);
                                {% endif %}
                            },
                            {% if video_url %}
                                slideChangeTransitionEnd: function () {
                                    const $parent = $(this.el).closest(".js-product-detail");
                                    const $labelsFloatingGroup = $parent.find(".js-labels-floating-group");
                                    if($(".js-product-video-slide").hasClass("swiper-slide-active")){
                                        $labelsFloatingGroup.fadeOut(100);
                                    }else{
                                        $labelsFloatingGroup.fadeIn(100);
                                    }
                                    $('.js-video').show();
                                    $('.js-video-iframe').hide().find("iframe").remove();
                                },
                            {% endif %}
                        },
                    },
                    function(swiperInstance) {
                        productSwiper = swiperInstance;
                    }
                );

                $().fancybox({
                    selector : '[data-fancybox="product-gallery"]',
                    toolbar  : false,
                    smallBtn : true,
                    beforeClose : function(instance) {                    
                        // Update position of the slider
                        productSwiper.slideTo( instance.currIndex, 0 );
                        
                      }
                });

                {% if has_multiple_slides %}
                    LS.registerOnChangeVariant(function(variant){
                        var liImage = $('.js-swiper-product').find("[data-image='"+variant.image+"']");
                        var selectedPosition = liImage.data('image-position');
                        var slideToGo = parseInt(selectedPosition);
                        productSwiper.slideTo(slideToGo);
                        $(".js-product-slide-img").removeClass("js-active-variant");
                        liImage.find(".js-product-slide-img").addClass("js-active-variant");
                    });
                {% endif %}
            }

            if ( $(window).width() < 768 ) {
                productSliderNav ()
            } else {
                {% if product.images_count > 1 %}
                    $(".js-sticky-product").stick_in_parent({
                        recalc_every : 5,
                    });
                {% endif %}
                LS.registerOnChangeVariant(function(variant){
                    var liImage = $('.js-swiper-product').find("[data-image='"+variant.image+"']");
                    var selectedScroll = liImage.position.top;
                    $('html, body').animate({
                        scrollTop: $(liImage).offset().top
                    }, 1000);
                });

                $(window).resize(function() {
                    if ( $(window).width() < 768 ) {
                        productSliderNav()
                    }
                });
            }

        {# /* // Pinterest sharing */ #}

        $('.js-pinterest-share').click(function(e){
            e.preventDefault();
            $(".pinterest-hidden a")[0].click();
        });

    {% endif %}

    {# Product quantitiy #}

    $(document).on("click", ".js-quantity-up", function () {
        $quantity_input = $(this).closest(".js-quantity").find(".js-quantity-input");
        $quantity_input.val( parseInt($quantity_input.val(), 10) + 1);
    });

    $(document).on("click", ".js-quantity-down", function () {
        $quantity_input = $(this).closest(".js-quantity").find(".js-quantity-input");
        quantity_input_val = $quantity_input.val();
        if (quantity_input_val>1) { 
            $quantity_input.val( parseInt($quantity_input.val(), 10) - 1);
        }
    });

    {#/*============================================================================
      #Cart
    ==============================================================================*/ #}

    {# /* // Free shipping bar */ #}

    {% if cart.free_shipping.min_price_free_shipping.min_price %}

        {# Updates free progress on page load #}

        LS.freeShippingProgress(true);

    {% endif %}

    {# /* // Position of cart page summary */ #}

    var head_height = $(".js-head-main").outerHeight();

    if ($(window).width() > 768) {
        $("#cart-sticky-summary").css("top" , head_height + 10);
    }

    {# /* // Add to cart */ #}

    $(document).on("click", ".js-addtocart:not(.js-addtocart-placeholder)", function (e) {

        {# Button variables for transitions on add to cart #}

        var $productContainer = $(this).closest('.js-product-container');
        var $productVariants = $productContainer.find(".js-variation-option");
        var $productButton = $productContainer.find("input[type='submit'].js-addtocart");
        var $QuickshopButtonContainer = $productContainer.find(".js-quickshop-add-container");
        var $productButtonPlaceholder = $productContainer.find(".js-addtocart-placeholder");
        var $productButtonText = $productButtonPlaceholder.find(".js-addtocart-text");
        var $productButtonAdding = $productButtonPlaceholder.find(".js-addtocart-adding");
        var $productButtonSuccess = $productButtonPlaceholder.find(".js-addtocart-success");

        {# Define if event comes from quickshop, product page or cross selling #}

        var isQuickShop = $productContainer.hasClass('js-quickshop-container');
        var isQuickShopdirect = $productContainer.hasClass('js-quickshop-direct');
        var isCrossSelling = $productContainer.hasClass('js-cross-selling-container');

        {# Add item information for notification #}

        var quantity = $productContainer.find('.js-quantity-input').val();

        if ($productButton.hasClass("js-quickshop-icon-add")) {
            var addedToCartCopy = "";
        } else {
            var addedToCartCopy = "{{ 'Agregar al carrito' | translate }}";
        }

        if (isCrossSelling) {
            var imageSrc = $productContainer.find('.js-cross-selling-product-image').attr('src');
            quantity = $productContainer.data('quantity')
            var name = $productContainer.find('.js-cross-selling-product-name').text();
            var price = $productContainer.find('.js-cross-selling-promo-price').text();
            addedToCartCopy = $productContainer.data('add-to-cart-translation');
        } else if (!isQuickShop) {
            if($(".js-product-slide-img.js-active-variant").length) {
                var imageSrc = $($productContainer.find('.js-product-slide-img.js-active-variant')[0]).data('srcset').split(' ')[0];
            } else {
                var imageSrc = $($productContainer.find('.js-product-slide-img')[0]).attr('srcset').split(' ')[0];
            }
            var name = $productContainer.find('.js-product-name').text();
            var price = $productContainer.find('.js-price-display').text();
        } else {
            var imageSrc = $(this).closest('.js-quickshop-container').find('img').attr('srcset');
            var name = $productContainer.find('.js-item-name').text();
            var price = $productContainer.find('.js-price-display').text().trim(); 
        }

        if (!$(this).hasClass('contact')) {

            e.preventDefault();

            {# Hide real button and show button placeholder during event #}
            if (isQuickShopdirect) {
                $QuickshopButtonContainer.hide();
            }else{
                $productButton.hide();
            }
            $productButtonPlaceholder.show().addClass("active");
            $productButtonText.removeClass("active");
            setTimeout(function(){
                $productButtonAdding.addClass("active");
            },300);

            var callback_add_to_cart = function(html_notification_related_products, html_notification_cross_selling) {

                {# Animate cart amount #}

                $(".js-cart-widget-amount").addClass("beat");

                setTimeout(function(){
                    $(".js-cart-widget-amount").removeClass("beat");
                },4000);

                {# Fill notification info #}

                $('.js-cart-notification-item-img').attr('srcset', imageSrc);
                $('.js-cart-notification-item-name').text(name);
                $('.js-cart-notification-item-quantity').text(quantity);
                $('.js-cart-notification-item-price').text(price);

                if($productVariants.length){
                    var output = [];

                    $productVariants.each( function(){  
                        var variants = $(this);
                        output.push(variants.val());
                    });
                    $(".js-cart-notification-item-variant-container").show();
                    $(".js-cart-notification-item-variant").text(output.join(', '))
                }else{
                    $(".js-cart-notification-item-variant-container").hide();
                }

                {# Set products amount wording visibility #}

                var cartItemsAmount = $(".js-cart-widget-amount").first().text();

                if(cartItemsAmount > 1){
                    $(".js-cart-counts-plural").show();
                    $(".js-cart-counts-singular").hide();
                }else{
                    $(".js-cart-counts-singular").show();
                    $(".js-cart-counts-plural").hide();
                }

                {# Show button placeholder with transitions #}

                $productButtonAdding.removeClass("active");

                setTimeout(function(){
                    $productButtonSuccess.addClass("active");
                },300);
                setTimeout(function(){
                    $productButtonSuccess.removeClass("active");
                    setTimeout(function(){
                        $productButtonText.addClass("active");
                    },300);
                    $productButtonPlaceholder.removeClass("active");
                },2000);

                setTimeout(function(){
                    $productButtonPlaceholder.hide();
                    if (isQuickShopdirect) {
                        $QuickshopButtonContainer.show();
                    }else{
                        $productButton.show();
                    }
                },4000);

                $productContainer.find(".js-added-to-cart-product-message").slideDown();

                if (isQuickShop || isCrossSelling) {
                    closeModal($(".js-addtocart:not(.js-addtocart-placeholder)"));
                    if ($(window).width() < 768) {
                        cleanURLHash();
                    }
                }

                let notificationWithRelatedProducts = false;

                {% if settings.add_to_cart_recommendations %}

                    {# Show added to cart product related products #}

                    function recommendProductsOnAddToCart(){

                        $('.js-related-products-notification-container').html("");

                        modalOpen('#related-products-notification');

                        $('.js-related-products-notification-container').html(html_notification_related_products).show();

                        {# Recommendations swiper #}

                        // Set loop for recommended products

                        function calculateRelatedNotificationLoopVal(sectionSelector) {
                            let productsAmount = $(sectionSelector).attr("data-related-amount");
                            let loopVal = false;
                            const applyLoop = (window.innerWidth < 768 && productsAmount > 2.5) || (window.innerWidth > 768 && productsAmount > 4);
                            
                            if (applyLoop) {
                                loopVal = true;
                            }
                            
                            return loopVal;
                        }

                        let cartRelatedLoopVal = calculateRelatedNotificationLoopVal(".js-related-products-notification");

                        // Create new swiper on add to cart

                        createSwiper('.js-swiper-related-products-notification', {
                            lazy: true,
                            loop: cartRelatedLoopVal,
                            watchOverflow: true,
                            threshold: 5,
                            watchSlideProgress: true,
                            watchSlidesVisibility: true,
                            spaceBetween: 20,
                            slideVisibleClass: 'js-swiper-slide-visible',
                            slidesPerView: 2.5,
                            navigation: {
                                nextEl: '.js-swiper-related-products-notification-next',
                                prevEl: '.js-swiper-related-products-notification-prev',
                            },
                            breakpoints: {
                                768: {
                                    slidesPerView: 4,
                                }
                            }
                        });
                    }
                    
                    notificationWithRelatedProducts = html_notification_related_products != null;

                    if(notificationWithRelatedProducts){
                        if (isQuickShop) {
                            setTimeout(function(){
                                recommendProductsOnAddToCart();
                            },300);
                        }else{
                            recommendProductsOnAddToCart();
                        }
                    }

                {% endif %}

                let shouldShowCrossSellingModal = html_notification_cross_selling != null;

                if(!notificationWithRelatedProducts){
                    if ($(window).width() > 768 && !shouldShowCrossSellingModal) {

                        {# Open cart on add to cart #}

                        $(".js-toggle-cart").click();
                    }else{
                       {# Show notification and hide it only after second added to cart #}

                        setTimeout(function(){
                            $(".js-alert-added-to-cart").show().addClass("notification-visible").removeClass("notification-hidden");
                        },500);

                        if (!cookieService.get('first_product_added_successfully')) {
                            cookieService.set('first_product_added_successfully', 1, 7 );
                        } else{
                            setTimeout(function(){
                                $(".js-alert-added-to-cart").removeClass("notification-visible").addClass("notification-hidden");
                                setTimeout(function(){
                                    $('.js-cart-notification-item-img').attr('src', '');
                                    $(".js-alert-added-to-cart").hide();
                                },2000);
                            },8000);
                        }
                    }
                }

                {# Show cart footer #}

                $(".js-visible-on-cart-filled").removeClass("d-none");

                {# Display cross-selling promotion modal #}

                if (shouldShowCrossSellingModal) {
                    jQueryNuvem('#modal-cart').hide();

                    jQueryNuvem('.js-cross-selling-modal-body').html("");
                    modalOpen('#js-cross-selling-modal');
                    jQueryNuvem('.js-cross-selling-modal-body').html(html_notification_cross_selling).show();
                }

                {# Change prices on cross-selling promotion modal #}

                const crossSellingContainer = document.querySelector('.js-cross-selling-container');

                if (crossSellingContainer) {
                    LS.fillCrossSelling(crossSellingContainer);
                }

                {# Update shipping input zipcode on add to cart #}

                {# Use zipcode from input if user is in product page, or use zipcode cookie if is not #}

                if ($("#product-shipping-container .js-shipping-input").val()) {
                    zipcode_on_addtocart = $("#product-shipping-container .js-shipping-input").val();
                    $("#cart-shipping-container .js-shipping-input").val(zipcode_on_addtocart);
                    $(".js-shipping-calculator-current-zip").text(zipcode_on_addtocart);
                } else if (cookieService.get('calculator_zipcode')){
                    var zipcode_from_cookie = cookieService.get('calculator_zipcode');
                    $('.js-shipping-input').val(zipcode_from_cookie);
                    $(".js-shipping-calculator-current-zip").text(zipcode_from_cookie);
                }

                if (isCrossSelling) {
                    {# Automatically close the cross-selling modal by triggering its close button #}

                    jQueryNuvem('#js-cross-selling-modal .js-modal-close').trigger('click');

                    {# Hide the "added to cart" notification and show the cart modal #}

                    if ($(window).width() > 768) {
                        jQueryNuvem(".js-alert-added-to-cart").removeClass("notification-visible").addClass("notification-hidden");
                        jQueryNuvem(".js-toggle-cart").click();
                    }
                }
            }
            var callback_error = function(){

                {# Restore real button visibility in case of error #}

                $productButtonPlaceholder.removeClass("active");
                $productButtonText.fadeIn("active");
                $productButtonAdding.removeClass("active");
                $productButtonPlaceholder.hide();
                if (isQuickShopdirect) {
                    $QuickshopButtonContainer.show();
                }else{
                    $productButton.show();
                }
            }
            $prod_form = $(this).closest("form");
            LS.addToCartEnhanced(
                $prod_form,
                addedToCartCopy,
                '{{ "Agregando..." | translate }}',
                '{{ "¡Uy! No tenemos más stock de este producto para agregarlo al carrito." | translate }}',
                {{ store.editable_ajax_cart_enabled ? 'true' : 'false' }},
                    callback_add_to_cart,
                    callback_error
            );
        }
    });

    {# /* // Toggle cart totals */ #}

    $(document).on("click", ".js-toggle-cart-total-details", function(e) {
        e.preventDefault();
        $(".js-toggle-cart-totals").slideToggle("fast");
        $(".js-cart-toggle-icon").toggle();
    });

    {# /* // Cart quantitiy changes */ #}

    $(document).on("keypress", ".js-cart-quantity-input", function (e) {
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            return false;
        }
    });

    $(document).on("focusout", ".js-cart-quantity-input", function (e) {
        var itemID = $(this).attr("data-item-id");
        var itemVAL = $(this).val();
        if (itemVAL == 0) {
            var r = confirm("{{ '¿Seguro que quieres borrar este artículo?' | translate }}");
            if (r == true) {
                LS.removeItem(itemID, true);
            } else {
                $(this).val(1);
            }
        } else {
            LS.changeQuantity(itemID, itemVAL, true);
        }
    });

    {# /* // Empty cart alert */ #}

    $(".js-trigger-empty-cart-alert").click(function (e) {
        e.preventDefault();
        $(".js-mobile-nav-empty-cart-alert").fadeIn(100).delay(1500).fadeOut(500);
    });

    {# /* // Go to checkout */ #}

    {# Clear cart notification cookie after consumers continues to checkout #}

    $('form[action="{{ store.cart_url | escape('js') }}"]').submit(function() {
        cookieService.remove('first_product_added_successfully');
    }); 

    {#/*============================================================================
      #Shipping calculator
    ==============================================================================*/ #}

    {# /* // Cart shipping cost */ #}

    if ($('.js-selected-shipping-method').length) {
        var shipping_cost = $('.js-selected-shipping-method').data("cost");
        var $shippingCost = $("#shipping-cost");
        $shippingCost.text(shipping_cost);
        $shippingCost.removeClass('opacity-40');
    }

    {# /* // Select and save shipping function */ #}

    selectShippingOption = function(elem, save_option) {
        $(".js-shipping-method, .js-branch-method").removeClass('js-selected-shipping-method');
        $(elem).addClass('js-selected-shipping-method');

        {% if settings.shipping_calculator_cart_page %}

            var shipping_cost = $(elem).data("cost");
            var shipping_price_clean = $(elem).data("price");

            if(shipping_price_clean = 0.00){
                var shipping_cost = '{{ Gratis | translate }}'
            }

            // Updates shipping (ship and pickup) cost on cart
            var $shippingCost = $("#shipping-cost");
            $shippingCost.text(shipping_cost);
            $shippingCost.removeClass('opacity-40');

        {% endif %}
        
        if (save_option) {
            LS.saveCalculatedShipping(true);
        }
        var $closest_shipping_container = $(elem).closest(".js-shipping-calculator-container");
        if($(elem).hasClass("js-shipping-method-hidden")){
            $closest_shipping_container.find(".js-shipping-see-more").hide();
            $closest_shipping_container.find(".js-shipping-see-less").show();
            $closest_shipping_container.find(".js-other-shipping-options").show();
        }
    };

    {# Apply zipcode saved by cookie if there is no zipcode saved on cart from backend #}

    if (cookieService.get('calculator_zipcode')) {

        {# If there is a cookie saved based on previous calcualtion, add it to the shipping input to triggert automatic calculation #}

        var zipcode_from_cookie = cookieService.get('calculator_zipcode');
        $('#product-shipping-container .js-shipping-input').val(zipcode_from_cookie);
        $(".js-shipping-calculator-current-zip").text(zipcode_from_cookie);

        {# Hide the shipping calculator and show spinner  #}

        $(".js-shipping-calculator-head").addClass("with-zip").removeClass("with-form");
        $(".js-shipping-calculator-with-zipcode").addClass("transition-up-active");
        $(".js-shipping-calculator-spinner").show();
    } else {

        {# If there is no cookie saved, show calcualtor #}

        $(".js-shipping-calculator-form").addClass("transition-up-active");
    }

    {# Remove shipping suboptions from DOM to avoid duplicated modals #}

    removeShippingSuboptions = function(){
        var shipping_suboptions_id = $(".js-modal-shipping-suboptions").attr("id");
        $("#" + shipping_suboptions_id).remove();
        $('.js-modal-overlay[data-modal-id="#' + shipping_suboptions_id + '"').remove();
    };

    {# /* // Calculate shipping function */ #}

    $(".js-calculate-shipping").click(function (e) {
        e.preventDefault();

        {# Take the Zip code to all shipping calculators on screen #}
        let shipping_input_val = $(this).closest(".js-shipping-calculator-form").find(".js-shipping-input").val();

        $(".js-shipping-input").val(shipping_input_val);

        {# Calculate on page load for both calculators: Product and Cart #}

        {% if template == 'product' %}
            LS.calculateShippingAjax(
                $('#product-shipping-container').find(".js-shipping-input").val(), 
                '{{store.shipping_calculator_url | escape('js')}}',
                $("#product-shipping-container").closest(".js-shipping-calculator-container") );
        {% endif %}

        if ($(".js-cart-item").length) {
            LS.calculateShippingAjax(
                $('#cart-shipping-container').find(".js-shipping-input").val(), 
                '{{store.shipping_calculator_url | escape('js')}}',
                $("#cart-shipping-container").closest(".js-shipping-calculator-container") );
        }

        $(".js-shipping-calculator-current-zip").html(shipping_input_val);
        removeShippingSuboptions();

    });

    {# /* // Calculate shipping by submit */ #}

    $(".js-shipping-input").keydown(function (e) {
        var key = e.which ? e.which : e.keyCode;
        var enterKey = 13;
        if (key === enterKey) {
            e.preventDefault();
            $(this).closest(".js-shipping-calculator-form").find(".js-calculate-shipping").click();
            if ($(window).width() < 768) {
                $(this).blur();
            }
        }
    });

    {# /* // Shipping and branch click */ #}

    $(document).on("change", ".js-shipping-method, .js-branch-method", function () {
        selectShippingOption(this, true);
        $(".js-shipping-method-unavailable").hide();
    });

    {# /* // Select shipping first option on results */ #}

    $('.js-shipping-method:checked').livequery(function () {
        let shippingPrice = $(this).attr("data-price");
        LS.addToTotal(shippingPrice);

        let total = (LS.data.cart.total / 100) + parseFloat(shippingPrice);
        $(".js-cart-widget-total").html(LS.formatToCurrency(total));

        selectShippingOption(this, false);
    });

    {# /* // Toggle branches link */ #}

    $(document).on("click", ".js-toggle-branches", function (e) {
        e.preventDefault();
        $(".js-store-branches-container").slideToggle("fast");
        $(".js-see-branches, .js-hide-branches").toggle();
    });

    {# /* // Toggle more shipping options */ #}

    $(document).on("click", ".js-toggle-more-shipping-options", function(e) {
        e.preventDefault();

        {# Toggle other options depending if they are pickup or delivery for cart and product at the same time #}

        if($(this).hasClass("js-show-other-pickup-options")){
            $(".js-other-pickup-options").slideToggle(600);
            $(".js-show-other-pickup-options .js-shipping-see-less, .js-show-other-pickup-options .js-shipping-see-more").toggle();
        }else{
            $(".js-other-shipping-options").slideToggle(600);
            $(".js-show-more-shipping-options .js-shipping-see-less, .js-show-more-shipping-options .js-shipping-see-more").toggle();
        }
    });

    {# /* // Calculate shipping on page load */ #}

    {# Only shipping input has value, cart has saved shipping and there is no branch selected #}

    calculateCartShippingOnLoad = function(){
        if($("#cart-shipping-container .js-shipping-input").val()){
       
            // If user already had calculated shipping: recalculate shipping
           
           setTimeout(function() { 
                LS.calculateShippingAjax(
                    $('#cart-shipping-container').find(".js-shipping-input").val(), 
                    '{{store.shipping_calculator_url | escape('js')}}',
                    $("#cart-shipping-container").closest(".js-shipping-calculator-container") );
                    removeShippingSuboptions();
            }, 100);
        } 

        if($(".js-branch-method").hasClass('js-selected-shipping-method')){
            
            {% if store.branches|length > 1 %}
                $(".js-store-branches-container").slideDown("fast");
                $(".js-see-branches").hide();
                $(".js-hide-branches").show();
            {% endif %}
        }
    };
    
    {% if cart.has_shippable_products %}
        calculateCartShippingOnLoad();
    {% endif %}

    {# /* // Calculate product detail shipping on page load */ #}

    {% if template == 'product' %}

        if($('#product-shipping-container').find(".js-shipping-input").val()){
            setTimeout(function() { 
                LS.calculateShippingAjax(
                    $('#product-shipping-container').find(".js-shipping-input").val(), 
                    '{{store.shipping_calculator_url | escape('js')}}',
                    $("#product-shipping-container").closest(".js-shipping-calculator-container") );
                
                removeShippingSuboptions();
            }, 100);
        }

    {% endif %}

    {# /* // Change CP */ #}

    $(document).on("click", ".js-shipping-calculator-change-zipcode", function(e) {
        e.preventDefault();
        $(".js-shipping-calculator-response").fadeOut(100);
        $(".js-shipping-calculator-head").addClass("with-form").removeClass("with-zip");
        $(".js-shipping-calculator-with-zipcode").removeClass("transition-up-active");
        $(".js-shipping-calculator-form").addClass("transition-up-active");
    }); 

    {# /* // Shipping provinces */ #}

    {% if provinces_json %}
        $('select[name="country"]').change(function () {
            var provinces = {{ provinces_json | default('{}') | raw }};
            LS.swapProvinces(provinces[$(this).val()]);
        }).change();
    {% endif %}

    {# /* // Change store country: From invalid zipcode message */ #}

    $(document).on("click", ".js-save-shipping-country", function(e) {
        e.preventDefault();
        {# Change shipping country #}

        var selected_country_url = $(this).closest(".js-modal-shipping-country").find(".js-shipping-country-select option:selected").attr("data-country-url");
        location.href = selected_country_url; 

        $(this).text('{{ "Aplicando..." | translate }}').addClass("disabled");
    });

    {#/*============================================================================
      #Forms
    ==============================================================================*/ #}

    $(".js-winnie-pooh-form").submit(function (e) {
        $(this).attr('action', '');
    });

    {# Show the success or error message when resending the validation link #}

    {% if template == 'account.register' or template == 'account.login' %}
        $(".js-resend-validation-link").click(function(e){
            window.accountVerificationService.resendVerificationEmail('{{ customer_email }}');
        });
    {% endif %}

    {% if template == 'account.login' %}
        {% if result.invalid %}
            $(".js-account-input").addClass("alert-danger");
            $(".js-account-input.alert-danger").focus(function() {
              $(".js-account-input").removeClass("alert-danger");
            });
        {% endif %}
    {% endif %}

    $('.js-password-view').click(function () {
        $(this).toggleClass('password-view');
        if($(this).hasClass('password-view')){
           $(this).parent().find(".js-password-input").attr('type', '');
           $(this).find(".js-eye-open, .js-eye-closed").toggle();
        } else {
           $(this).parent().find(".js-password-input").attr('type', 'password');
           $(this).find(".js-eye-open, .js-eye-closed").toggle();
        }
    });

    {#/*============================================================================
      #Footer
    ==============================================================================*/ #}

    {% if store.afip %}

        {# Add alt attribute to external AFIP logo to improve SEO #}

        $('img[src*="www.afip.gob.ar"]').attr('alt', '{{ "Logo de AFIP" | translate }}');

    {% endif %}

    {#/*============================================================================
      #Empty placeholders
    ==============================================================================*/ #}

    {% set show_help = not has_products %}

    {% if template == 'home' %}

        {# /* // Home slider */ #}

        var width = window.innerWidth;
        if (width > 767) {  
            var slider_empty_autoplay = {delay: 6000,};
        } else {
            var slider_empty_autoplay = false;
        }

        window.homeEmptySlider = {
            getAutoRotation: function() {
                return slider_empty_autoplay;
            },
        };
        var homeEmptySwiper = new Swiper ('.js-home-empty-slider', {
            loop: true,
            autoplay: slider_empty_autoplay,
            pagination: {
                el: '.js-swiper-empty-home-pagination',
                clickable: true,
            },
        });

        {# /* // Banners home */ #}

        var bannersSwiper = new Swiper ('.js-swiper-banners-demo', {
            lazy: true,
            watchOverflow: true,
            slidesPerView: 1.2,
            breakpoints: {
                768: {
                    slidesPerView: 3,
                }
            }
        });

        {# /* // Home demo products slider */ #}

        var demoFeaturedSwiper = new Swiper ('.js-swiper-featured-demo', {
            lazy: true,
            watchOverflow: true,
            threshold: 5,
            spaceBetween: 20,
            slidesPerView: 1.2,
            navigation: {
                nextEl: '.js-swiper-featured-demo-next',
                prevEl: '.js-swiper-featured-demo-prev',
            },
            breakpoints: {
                768: {
                    slidesPerView: {% if columns == 1 %}2{% elseif columns == 2 %}3{% else %}4{% endif %},
                }
            }
        });

        {# /* // Brands slider */ #}

        var brandsSwiper = new Swiper ('.js-swiper-brands-demo', {
            lazy: true,
            loop: true,
            watchOverflow: true,
            centerInsufficientSlides: true,
            slidesPerView: 2,
            slidesPerColumn: 3,
            breakpoints: {
                768: {
                    slidesPerView: 3,
                    slidesPerColumn: 2,
                }
            }
        });

    {% endif %}

    {% if template == '404' and show_help %}

        {% set columns = settings.grid_columns %}

        {# /* // Product slider */ #}

        var productSwiper = new Swiper ('.js-swiper-product-demo', {
            lazy: true,
            loop: false,
            pagination: {
                el: '.js-swiper-product-demo-pagination',
                type: 'fraction',
                clickable: true,
            },
        });

        {# /* // Product related */ #}

        var relatedSwiper = new Swiper ('.js-swiper-related-demo', {
            lazy: true,
            watchOverflow: true,
            threshold: 5,
            watchSlideProgress: true,
            watchSlidesVisibility: true,
            navigation: {
                nextEl: '.js-swiper-related-demo-next',
                prevEl: '.js-swiper-related-demo-prev',
            },
            spaceBetween: 20,
            slidesPerView: 1.5,
            breakpoints: {
                768: {
                    slidesPerView: {% if columns == 1 %}2{% elseif columns == 2 %}3{% else %}4{% endif %},
                }
            }
        });

        {# /* 404 handling to show the example product */ #}

        if (/\/product\/example\/?$/.test(window.location.pathname)) {
            document.title = "{{ "Producto de ejemplo" | translate | escape('js') }}";
            $("#404").hide();
            $("#product-example").show();
        } else {
            $("#product-example").hide();
        }

    {% endif %}

});
