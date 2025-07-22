{#/*============================================================================
style.css

    -This file contains all the theme non critical styles wich will be loaded asynchronously
    -Rest of styling can be found in:
      --static/css/style-colors.scss.tpl --> For color and font styles related to config/settings.txt
      --static/css/style-critical.tpl --> For critical CSS rendered inline before the rest of the site

==============================================================================*/#}

{#/*============================================================================
  Table of Contents

  #Components
    // Margin and Padding
    // Borders
    // Mixins
    // Animations
    // Buttons
    // Forms
    // Lists
    // Alerts and Notifications
    // Modals
    // Tabs
    // Cards
    // Icons
    // Captcha
  #Header and nav
    // Nav
    // Search
  #Footer
    // Nav
    // Newsletter
  #Home page
    // Featured products
    // Instafeed
    // Banners
    // Informative banners
    // Brands
    // Sections
  #Product grid
    // Quickshop
    // Filters
  #Product detail
  	// Image
  	// Form and info
  #Cart detail
  #Media queries
    // Min width 768px
      //// Components
      //// Home
      //// Footer
  #Critical path utilities

==============================================================================*/#}

{#/*============================================================================
  #Components
==============================================================================*/#}

{# /* // Margin and Padding */ #}

%section-margin {
  margin-bottom: 70px;
}
%element-margin {
  margin-bottom: 35px;
}
%element-margin-small {
  margin-bottom: 20px;
}

{# /* // Borders */ #}

{# This mixin allows SASS to use the same property outside and inside media queries #}

@mixin border-radius {
  border-radius: 10px;
}

%border-radius {
  @include border-radius;
}

.border-radius {
  @extend %border-radius;
}

{# /* // Mixins */ #}

{# This mixin adds browser prefixes to a CSS property #}

@mixin prefix($property, $value, $prefixes: ()) {
  @each $prefix in $prefixes {
    #{'-' + $prefix + '-' + $property}: $value;
  }
  #{$property}: $value;
}


{# /* // Animations */ #}

.transition-soft {
  @include prefix(transition, all 0.3s ease, webkit ms moz o);
}

.transition-up {
  position: relative;
  top: -8px;
  z-index: 10;
  @include prefix(transition, all 0.5s ease, webkit ms moz o);
  pointer-events: none; 
  &-active {
    top: 0;
    opacity: 1; 
    z-index: 100;
    pointer-events: all; 
  }
}

.beat {
  animation: .8s 2 beat;
}
@keyframes beat {
  0% {
    @include prefix(transform, scale(1), webkit ms moz o);
  }
  25% {
    @include prefix(transform, scale(1.3), webkit ms moz o);
  }
  40% {
    @include prefix(transform, scale(1), webkit ms moz o);
  }
  60% {
    @include prefix(transform, scale(1.3), webkit ms moz o);
  }
  100% {
    @include prefix(transform, scale(1), webkit ms moz o);
  }
}

@keyframes bounceIn{
  0%{
    transform: scale(1) translate3d(0,0,0);
  }
  50%{
    transform: scale(1.2);
  }
  80%{
    transform: scale(0.89);
  }
  100%{
    transform: scale(1) translate3d(0,0,0);
  }
}

{# /* // Buttons */ #}

.btn-transition {
  position: relative;
  overflow: hidden;
  .transition-container {
    position: absolute;
    top: 50%;
    left: 0;
    width: 100%;
    margin-top: -8px;
    opacity: 0;
    text-align: center;
    @include prefix(transition, all 0.5s ease, webkit ms moz o);
    cursor: not-allowed;
    pointer-events: none;
    &.active {
      opacity: 1;
    }
  }
  .btn-transition-progress {
    margin-top: 1px;
  }
  &.item-btn-quickshop .transition-container {
    margin-top: -18px;
  }
} 

.btn-stroke-gradient {
  position: relative;
  z-index: 9;
  padding: 15px;
  @extend %element-margin;
  clear: both;
  text-align: center;
  border: 0;
  @extend %border-radius;
}

{# /* // Forms */ #}

.form-group{
  @extend %element-margin-small;
  .form-label{
    float: left;
    width: 100%;
    margin-bottom: 10px;
  }
  .alert{
    margin: 10px 0 0 0;
  }
}

.input-clear-content {
  position: absolute;
  right: 4px;
  bottom: 4px;
  width: 24px;
  height: 35px;
  padding: 1px;
  cursor: pointer;
  &:before {
    display: block;
    margin: 8px 0 0 6px;
  }
}

.radio-button{
  margin-bottom: 0;
  -webkit-tap-highlight-color: rgba(0,0,0,0);
  cursor: pointer;
  &.disabled{
    opacity: 0.6;
    cursor: not-allowed;
    input[type="radio"] {
      cursor: not-allowed;
    }
  }
  &-content{
    position: relative;
    width: 100%;
    float: left;
    padding: 20px 25px; 
    clear: both;
    box-sizing: border-box;
  }
  &-icons-container{
    position: absolute;
    top: 19px;
    left: 10px;
  }
  &-icons{
    position: relative;
    float: left;
  }
  &-icon{
    width: 16px;
    height: 16px;
    border-radius: 50%;
  }
  input[type="radio"]{
    display: none;
    & +  .radio-button-content .unchecked{
      float: left;
    }
    & +  .radio-button-content .checked{
      position: absolute;
      top: 10px;
      left: 10px;
      width: 14px;
      height: 14px;      
      @include prefix(transform, translate(-50%,-50%), webkit ms moz o);
      @include prefix(transition, all 0.2s , webkit ms moz o);
    }
    &:checked {
      .shipping-method-name{
        font-weight: bold;
      } 
      + .radio-button-content .checked{
        width: 4px;
        height: 4px;
      }  
    } 
  }
  &-label{
    width: 100%;
    float: left;
    padding-left: 25px;
  }
}

.radio-button-item:last-of-type .radio-button{
  margin-bottom: 0;
}

.checkbox-container{
  .checkbox {
    position: relative;
    display: inline-block;
    padding: 10px;
    margin-right: 5px;
    margin-bottom: 10px;
    line-height: 20px;
    cursor: pointer;
    @extend %border-radius;
    @include prefix(user-select, none, webkit ms moz o);

    &-color {
      display: inline-block;
      width: 20px;
      height: 20px;
      margin: 0 0 2px 5px;
      vertical-align: middle;
      border-radius: 100%;
    }
    &-icon {
      position: absolute;
      top: -1px;
      left: 0;
      width: 20px;
      height: 20px;

      &:after {
        position: absolute;
        top: 1px;
        left: 6px;
        display: none;
        width: 7px;
        height: 12px;
        content: '';
        @include prefix(transform, rotate(45deg), webkit ms moz o);
      }
    }
  }
  input {
    display: none;
    &:checked ~ .checkbox-icon:after {
      display: block;
    }
  }
}

.form-select {
  display: block;
  width: 100%;
  &:focus{
    outline:0;
  }
  &::-ms-expand {
    display: none;
  }
}

{# /* Disabled controls */ #}

input,
select,
textarea{
  &[disabled],
  &[disabled]:hover,
  &[readonly],
  &[readonly]:hover{
    background-color: #DDD;
    cursor: not-allowed; 
  }
}


{# /* Lists */ #}

.list-readonly .radio-button-label{
  width: 100%;
  padding-left: 0;
  cursor: default;
}

{# /* // Alerts and notifications */ #}

.alert {
  position: relative;
  z-index: 9;
  clear: both;
  padding: 15px;
  @extend %element-margin;
  text-align: center;
  @extend %border-radius;
  border: 0;
}

.notification-hidden{
  transition: all .3s cubic-bezier(.16,.68,.43,.99);
  @include prefix(transform, translateX(100%), webkit ms moz o);
  pointer-events: none;
}
.notification-visible{
  transition: all .3s cubic-bezier(.16,.68,.43,.99);
  @include prefix(transform, translateX(0), webkit ms moz o);
}
.notification-close {
  position: absolute;
  top: 0;
  right: 0;
  z-index: 1;
  font-size: 20px; 
  cursor: pointer;
}

/* // Progress bar */

.bar-progress {
  position: relative;
  height: 12px;
  min-width: 25px;
  border-radius: 60px;
  .bar-progress-active {
    position: relative;
    width: 0%;
    height: 12px;
    min-width: 25px;
    border-radius: 60px;
    &:after {
      position: absolute;
      top: -10px;
      right: -1px;
      height: 32px;
      width: 32px;
      content: '';
      border-radius: 100%;
    }
  }
  .bar-progress-icon {
    position: absolute;
    top: -7px;
    right: 5px;
    z-index: 1;
    text-align: center;
    font-size: 18px;
  }
}

.ship-free-rest-message {
  position: relative;
  height: 38px;
  margin-top: 20px;
  .ship-free-rest-text {
    position: absolute;
    top: -5px;
    width: 100%;
    text-align: center;  
    opacity: 0;
  }
  &.success .bar-progress-success,
  &.amount .bar-progress-amount,
  &.condition .bar-progress-condition  {
    top: 0;
    opacity: 1;
  }
}

{# /* // Modals */ #}

.modal {
  position: fixed;
  top: 0;
  display: block;
  width: 80%;
  height: 100%;
  padding: 20px;
  -webkit-overflow-scrolling: touch;
  overflow-y: auto;
  transition: all .2s cubic-bezier(.16,.68,.43,.99);
  z-index: 20000;
  &-quickshop {
    padding-bottom: 0;
    .modal-header {
      position: absolute;
      right: 30px;
      z-index: 1;
      margin-bottom: 0;
    }
    .quickshop-img-container {
      height: 130px;
      margin: -20px 0 0 -20px;
      overflow: hidden;
      border-radius: 10px 0 0 0;
      .quickshop-img {
        width: 120%;
        @include prefix(transform, translate(-10% , -10%), webkit ms moz o);
      }
    }
  }
  &-header{
    font-size: 32px;
    font-weight: 700;
  }
  &-body{
    margin-top: 20px;
  }
  &-footer{
    padding: 10px 0;
    clear: both;
  }
   &-with-fixed-footer {
    display: flex;
    flex-direction: column;
    height: 100%;
    .modal-scrollable-area {
      height: 100%;
      z-index: 2;
      overflow-y: auto;
      overflow-x: hidden;
    }
  }
  &-full {
    width: 100%;
  }
  &-docked-md{
    width: 100%;
  }
  &-centered-md-600px .modal-close{
    position: absolute;
    right: 20px;
  }
  &-docked-small{
    width: 80%;
  }
  &-top{
    top: -100%;
    left: 0;
  }
  &-bottom{
    top: 100%;
    left: 0;
  }
  &-left{
    left: -100%;
  }
  &-right{
    right: -100%;
  }
  &-centered{
    height: 100%;
    width: 100%;
    @extend %border-radius;
    &-small{
      left: 50%;
      width: 80%;
      height: auto;
      @include prefix(transform, translate(-50%, -50%), webkit ms moz o);
      .modal-body{
        min-height: 150px;
        max-height: 400px;
        overflow: auto;
      }
    }
  }
  &.modal-show{
    opacity: 1;
  }
  &-top.modal-show,
  &-bottom.modal-show {
    top: 0;
    &.modal-centered-small{
      top: 50%;
    }
  }
  &-top-sheet {
    height: auto;
    border-radius: 0 0 0 10px;
  }
  &-bottom-sheet {
    top: initial;
    bottom: -100%;
    width: 100%;
    height: auto;
    border-radius: 10px 10px 0 0;
    &.modal-show {
      top: initial;
      bottom: 0;
      height: auto;
    }
  }
  &-left.modal-show {
    left: 0;
  }
  &-right.modal-show {
    right: 0;
  }
  &-close { 
    display: block;
    margin-bottom: 20px;
    text-align: right;
    font-size: 24px;
    cursor: pointer;
  }
  .tab-group{
    width: calc(100% + 20px);
  }
}

.modal-overlay{
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: #00000047;
  z-index: 10000;
  &.modal-zindex-top{
    z-index: 20000;
  }
}

.fancybox-slide--html{
  .fancybox-content  {
    width: 100%;
    height: calc(100% - 70px) ;
    padding: 0;
    @include prefix(transform, translateY(20px), webkit ms moz o);
    background: transparent;
  }
  .fancybox-close-small {
    {# Hardcoded neutral color to match non iframe fancybox modal #}
    color: #ccc!important;
  }
}

.fancybox-toolbar {
  opacity: 1!important;
  visibility: visible!important;
  .fancybox-button {
    display: none!important;
    &.fancybox-button--close{
      display: block!important;
    }
  }
}

.fancybox-close-small {
  display: none!important;
}

{# /* // Tabs */ #}


.tab-group{
  width: 100vw;
  padding: 0;
  overflow-x: auto;
  white-space: nowrap;
  .tab{
    display: inline-flex;
    float: none;
    &-link{
      float: left;
      text-align: center;
    }
  }
}

.tab-panel:not(.tab-active){
  display: none;
}
.tab-panel.tab-active,
.tab-panel.active{
  display: block;
}

{# /* // Cards */ #}

.card {
  width: 100%;
  margin-bottom: 20px;
  padding: 20px;
  @extend %border-radius;
  &-collapse {
    height: 68px;
    padding: 0;
    overflow: hidden;
    border: none;
    @include prefix(transition, all 0.3s ease, webkit ms moz o);
    &-toggle {
      position: absolute;
      top: 6px;
      right: 5px;
      padding: 10px;
      cursor: pointer;
      @include prefix(transition, all 0.3s ease, webkit ms moz o);
      &.active {
        top: 14px;
        right: 15px;
        padding: 10px;
        transform: rotate(90deg);
      }
    }
    &.active {
      height: calc(100% - 20px);
    }
  }
  &-invert {
    width: 100%;
    margin-bottom: 20px;
    padding: 18px;
    @extend %border-radius;
    border: none;
  }
}

.card-body {
	-ms-flex: 1 1 auto;
	flex: 1 1 auto;
}

.card-header {
	padding: 15px 15px 0 15px;
	margin-bottom: 0;
}

{# /* // Icons */ #}

.svg-circle{
  width: 30px;
  height: 30px;
  padding: 8px;
  border-radius: 50%;
}

{# /* // Captcha */ #}

.g-recaptcha {
  margin-bottom: 24px;
}

.g-recaptcha > div {
  margin: 0 auto;
}

.grecaptcha-badge {
  bottom: 100px !important;
}

{#/*============================================================================
  #Header and nav
==============================================================================*/#}

{# /* // Nav */ #}

.modal-full-width {
  width: 100%;
  max-width: 100%;
}

.modal-body-scrollable-auto .modal-body {
  max-height: calc(100vh - 100px);
  overflow-y: auto;
}

.modal-nav-hamburger {
  .modal-header {
    margin-top: 25px;
    .modal-close {
      margin: 0;
      padding: 5px;
    }
  }
}

.nav-account {
  margin: 0 0 0 -20px;
  padding: 0 20px;
  list-style: none;
  border-radius: 0 10px 0 0;
  &-item {
    display: inline-block;
    font-size: 10px;
    text-transform: uppercase;
    letter-spacing: 1px;
  }
  &-link {
    display: block;
    padding: 15px 0;
  }
}

{# /* // Search */ #}

.search-container {
  position: relative;
  width: calc(100% - 40px);
  margin-top: -48px;
}

.search-input {
  padding-left: 30px;
  margin: 10px 0;
  border: 0;
}

.search-input[type="search"]::-webkit-search-cancel-button {
  -webkit-appearance:none
}

.search-input-submit {
  position: absolute;
  top: 15px;
  left: 0;
  padding: 0;
  font-size: 18px;
  background: none;
  border: 0;
}

.search-suggest {
  z-index: 99999;
  width: 100%;
  max-height: calc(100vh - 120px);
  overflow: hidden auto;
  &-list {
    margin: 0;
    padding: 0;
  }
  &-item {
    margin-bottom: 20px;
    padding: 0 15px;
    list-style: none;
    @extend %border-radius;
    overflow: hidden;
  }
  &-text {
    padding-top: 10px;
  }
  &-text,
  &-name {
    margin-bottom: 5px;
    line-height: 18px;
  }
  &-image-container {
    height: 100px;
    overflow: hidden;
  }
  &-image {
    display: block;
    max-width: 100px;
  }
}

{#/*============================================================================
  #Footer
==============================================================================*/#}

.footer-rounded {
  border-radius: 15px 0 0 0;
}

.footer-legal {
  padding: 20px 0 15px 0; 
  border-radius: 15px 15px 0 0;
}

{# /* // Nav */ #}

.footer-menu {
  list-style: none;
  &-item {
    display: block;
    text-transform: uppercase;
  }
  &-link {
    display: block;
    font-weight: 300;
    letter-spacing: 1px;
  }
}

{# /* // Newsletter */ #}

.newsletter {
  form {
    position: relative;
    .newsletter-btn {
      position: absolute;
      top: 0;
      right: 0;
      width: 52px;
      height: 52px;
      padding: 15px;
      text-indent: -99999px;
      &.btn {
        z-index: 9;
      }
    }
  } 
}

{# /* // Logos */ #}

.icon-logo,
.user-page-logos {
  width: auto;
  max-height: 25px;
  margin: 0 4px 4px 0;
  border-radius: 4px;
}

.powered-by-text {
  display: inline-block; }

.powered-by-logo {
  display: inline-block;
  width: 160px;
  margin-top: 5px;
}

.footer-logo {
  display: inline-block;
  margin-right: 15px;
  img {
    max-height: 70px;
  }
  &:last-child {
    margin: 0;
  }
}    
   
{#/*============================================================================
  #Home Page
==============================================================================*/#}

.section-banners-home,
.section-video-home {
  position: relative;
  padding-bottom: 30px;
}

.section-instafeed-home {
  position: relative;
  padding-bottom: 40px;
}

{# /* // Featured products */ #}

.section-featured-home,
.section-products-related,
.section-category-home {
  position: relative;
  padding-top: 50px;
}

.section-category-home {
  margin-bottom: -40px;
  padding-top: 80px;
}

.section-featured-home {
  margin-bottom: -40px;
  padding: 50px 0;
  border-radius: 20px 0 0 20px;
}

.section-category-home-background,
.section-products-related-background,
.section-account-background {
  position: absolute;
  top: 300px;
  bottom: 0;
  left: -8px;
  width: calc(100% + 8px);
  border-radius: 20px 0 0 0;
}
.section-products-related-background {
  top: calc(100% - 300px);
}

.section-account-background {
  top: 35px;
}

.section-category-home-background,
.section-informative-banners {
  border-radius: 20px 0 0 20px;
}

{# /* // Instafeed */ #}

.instagram-feed {
  margin-top: -60px;
}

.instafeed-card {
  position: relative;
  padding-bottom: 60%;
  border-radius: 15px;
  {% if settings.instagram_gradient %}
    background: linear-gradient(45deg, #FFAA4C 32.69%, #A21FAB 99.16%);
  {% endif %}
  overflow: hidden;
  &-full {
    height: 100%;
    margin-top: -80px;
    padding-bottom: 100%;
  }
}

.instafeed-profile {
  position: absolute;
  top: 50%;
  left: 50%;
  width: 100%;
  transform: translate(-50%, -50%);
}

.instafeed-user {
  font-size: 18px;
}

.instafeed-title {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  padding: 20px;
  {% if settings.instagram_gradient %}
    color: #fff;
    &:hover,
    &:focus {
      color: rgba(#fff, .8);
    }
  {% endif %}
}

.instafeed-link {
  position: relative;
  display: block;
  padding-top: 100%;
  @extend %border-radius;
  overflow: hidden;
  &:hover,
  &:focus {
    .instafeed-img {
      @include prefix(transform, scale(1.03), webkit ms moz o);
    }
    .instafeed-info {
      opacity: 1;
    }
  }
  .instafeed-img {
    position: absolute;
    top: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
    @include prefix(transition, all 0.8s ease, webkit ms moz o);
  }
  .instafeed-info {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    padding: 0;
    text-align: center;
    opacity: 0;
    @include prefix(transition, all 0.8s ease, webkit ms moz o);
    .instafeed-info-item {
      display: inline-block;
      margin-top: 45%;
    }
  }
}

{# /* // Banners */ #}

.textbanner {
  &-image-background {
    @include prefix(transition, all 0.8s ease, webkit ms moz o);
  }
  &:hover .textbanner-image-background,
  &:focus .textbanner-image-background {
    @include prefix(transform, scale(1.1), webkit ms moz o);
  }
}

{# /* // Informative banners */ #}

.section-informative-banners {
  position: relative;
  {% if not settings.positive_color_background %}
    margin-bottom: -40px;
  {% endif %}
  padding: 50px 0;
  text-align: center;
}

.service-item-image {
  display: inline-block;
  max-height: 120px;
}

{# /* // Brands */ #}

.section-brands-home {
  position: relative;
  margin: 40px 0;
  padding-top: 45px;
}

.brand-image {
  display: inline-block;
  max-width: 90%;
  max-height: 80px;
  vertical-align: middle;
  opacity: 0.5;
  @include prefix(transition, all 0.8s ease, webkit ms moz o);
  &:hover {
    opacity: 1;
  }
  &-container {
    line-height: 80px;
  }
}

{# /* // Sections backgrounds order */ #}

{% if not settings.positive_color_background %}
  .section-category-home + .section-video-home,
  .section-featured-home + .section-video-home,
  .section-informative-banners + .section-video-home,
  .section-category-home + .section-instafeed-home,
  .section-featured-home + .section-instafeed-home,
  .section-informative-banners + .section-instafeed-home {
    margin-bottom: -40px;
    padding-top: 40px;
    border-radius: 0 0 0 20px;
    + .section-banners-home,
    + .section-instafeed-home,
    + .section-video-home {
      margin-top: 70px;
    }
  }

  .section-category-home + .section-banners-home,
  .section-featured-home + .section-banners-home,
  .section-informative-banners + .section-banners-home {
    margin-top: 70px;
  }
{% endif %}

{# /* // Placeholder */ #}

.placeholder-overlay {
  position: absolute;
  top: 0;
  left: 0;
  z-index: 9;
  width: 100%;
  height: 100%;
  opacity: 0;
  &:hover,
  &:active,
  &:focus {
    opacity: 1;
  }
}

.placeholder-info {
  position: relative;
  top: 50%;
  left: 50%;
  width: 330px;
  max-width: 100%;
  padding: 30px 25px;
  text-align: center;
  line-height: 18px;
  transform: translate(-50%, -50%);
  .placeholder-description {
    margin: 20px 0;
  }
}

{#/*============================================================================
  #Product grid
==============================================================================*/#}

{#/* // Quickshop */ #}

.item-btn-quickshop + .alert {
  position: absolute;
  right: 10px;
  bottom: 40px;
  width: 450%;
  text-transform: initial;
  letter-spacing: initial;
}

{# /* // Filters */ #}

.filters-overlay {
  position: fixed;
  top: 0;
  left: 0;
  z-index: 30000;
  width: 100%;
  height: 100%;
  .filters-updating-message {
    position: absolute;
    top: 50%;
    left: 50%;
    width: 80%;
    text-align: center;
    @include prefix(transform, translate(-50%, -50%), webkit ms moz o);
    * {
      font-size: 24px;
      font-weight: normal;
    }
  }
}

.filter-input-price-container {
  position: relative;
  display: inline-block;
  width: 90px;
  margin-right: 5px;
  .filter-input-price {
    padding: 11px 25px 11px 11px;
  }
}

.filters-container{
  font-size: 16px;
}

{#/*============================================================================
  #Product detail
==============================================================================*/#}

.section-products-related {
  margin-bottom: -20px;
}

{# /* // Image */ #}

body.compensate-for-scrollbar{overflow:hidden}.fancybox-active{height:auto}.fancybox-is-hidden{left:-9999px;margin:0;position:absolute!important;top:-9999px;visibility:hidden}.fancybox-container{-webkit-backface-visibility:hidden;height:100%;left:0;outline:none;position:fixed;-webkit-tap-highlight-color:transparent;top:0;-ms-touch-action:manipulation;touch-action:manipulation;-webkit-transform:translateZ(0);transform:translateZ(0);width:100%;z-index:99992}.fancybox-container *{box-sizing:border-box}.fancybox-bg,.fancybox-inner,.fancybox-outer,.fancybox-stage{bottom:0;left:0;position:absolute;right:0;top:0}.fancybox-outer{-webkit-overflow-scrolling:touch;overflow-y:auto}.fancybox-bg{background:#1e1e1e;opacity:0;transition-duration:inherit;transition-property:opacity;transition-timing-function:cubic-bezier(.47,0,.74,.71)}.fancybox-is-open .fancybox-bg{opacity:.9;transition-timing-function:cubic-bezier(.22,.61,.36,1)}.fancybox-caption,.fancybox-infobar,.fancybox-navigation .fancybox-button,.fancybox-toolbar{direction:ltr;opacity:0;position:absolute;transition:opacity .25s ease,visibility 0s ease .25s;visibility:hidden;z-index:99997}.fancybox-show-caption .fancybox-caption,.fancybox-show-infobar .fancybox-infobar,.fancybox-show-nav .fancybox-navigation .fancybox-button,.fancybox-show-toolbar .fancybox-toolbar{opacity:1;transition:opacity .25s ease 0s,visibility 0s ease 0s;visibility:visible}.fancybox-infobar{color:#ccc;font-size:13px;-webkit-font-smoothing:subpixel-antialiased;height:44px;left:0;line-height:44px;min-width:44px;mix-blend-mode:difference;padding:0 10px;pointer-events:none;top:0;-webkit-touch-callout:none;-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none}.fancybox-toolbar{right:0;top:0}.fancybox-stage{direction:ltr;overflow:visible;-webkit-transform:translateZ(0);transform:translateZ(0);z-index:99994}.fancybox-is-open .fancybox-stage{overflow:hidden}.fancybox-slide{-webkit-backface-visibility:hidden;display:none;height:100%;left:0;outline:none;overflow:auto;-webkit-overflow-scrolling:touch;padding:44px;position:absolute;text-align:center;top:0;transition-property:opacity,-webkit-transform;transition-property:transform,opacity;transition-property:transform,opacity,-webkit-transform;white-space:normal;width:100%;z-index:99994}.fancybox-slide:before{content:"";display:inline-block;font-size:0;height:100%;vertical-align:middle;width:0}.fancybox-is-sliding .fancybox-slide,.fancybox-slide--current,.fancybox-slide--next,.fancybox-slide--previous{display:block}.fancybox-slide--image{overflow:hidden;padding:44px 0}.fancybox-slide--image:before{display:none}.fancybox-slide--html{padding:6px}.fancybox-content{background:#fff;display:inline-block;margin:0;max-width:100%;overflow:auto;-webkit-overflow-scrolling:touch;padding:44px;position:relative;text-align:left;vertical-align:middle}.fancybox-slide--image .fancybox-content{-webkit-animation-timing-function:cubic-bezier(.5,0,.14,1);animation-timing-function:cubic-bezier(.5,0,.14,1);-webkit-backface-visibility:hidden;background:transparent;background-repeat:no-repeat;background-size:100% 100%;left:0;max-width:none;overflow:visible;padding:0;position:absolute;top:0;-webkit-transform-origin:top left;transform-origin:top left;transition-property:opacity,-webkit-transform;transition-property:transform,opacity;transition-property:transform,opacity,-webkit-transform;-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;z-index:99995}.fancybox-can-zoomOut .fancybox-content{cursor:zoom-out}.fancybox-can-zoomIn .fancybox-content{cursor:zoom-in}.fancybox-can-pan .fancybox-content,.fancybox-can-swipe .fancybox-content{cursor:-webkit-grab;cursor:grab}.fancybox-is-grabbing .fancybox-content{cursor:-webkit-grabbing;cursor:grabbing}.fancybox-container [data-selectable=true]{cursor:text}.fancybox-image,.fancybox-spaceball{background:transparent;border:0;height:100%;left:0;margin:0;max-height:none;max-width:none;padding:0;position:absolute;top:0;-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;width:100%}.fancybox-spaceball{z-index:1}.fancybox-slide--iframe .fancybox-content,.fancybox-slide--map .fancybox-content,.fancybox-slide--pdf .fancybox-content,.fancybox-slide--video .fancybox-content{height:100%;overflow:visible;padding:0;width:100%}.fancybox-slide--video .fancybox-content{background:#000}.fancybox-slide--map .fancybox-content{background:#e5e3df}.fancybox-slide--iframe .fancybox-content{background:#fff}.fancybox-iframe,.fancybox-video{background:transparent;border:0;display:block;height:100%;margin:0;overflow:hidden;padding:0;width:100%}.fancybox-iframe{left:0;position:absolute;top:0}.fancybox-error{background:#fff;cursor:default;max-width:400px;padding:40px;width:100%}.fancybox-error p{color:#444;font-size:16px;line-height:20px;margin:0;padding:0}.fancybox-button{background:rgba(30,30,30,.6);border:0;border-radius:0;box-shadow:none;cursor:pointer;display:inline-block;height:44px;margin:0;padding:10px;position:relative;transition:color .2s;vertical-align:top;visibility:inherit;width:44px}.fancybox-button,.fancybox-button:link,.fancybox-button:visited{color:#ccc}.fancybox-button:hover{color:#fff}.fancybox-button:focus{outline:none}.fancybox-button.fancybox-focus{outline:1px dotted}.fancybox-button[disabled],.fancybox-button[disabled]:hover{color:#888;cursor:default;outline:none}.fancybox-button div{height:100%}.fancybox-button svg{display:block;height:100%;overflow:visible;position:relative;width:100%}.fancybox-button svg path{fill:currentColor;stroke-width:0}.fancybox-button--fsenter svg:nth-child(2),.fancybox-button--fsexit svg:nth-child(1),.fancybox-button--pause svg:nth-child(1),.fancybox-button--play svg:nth-child(2){display:none}.fancybox-progress{background:#ff5268;height:2px;left:0;position:absolute;right:0;top:0;-webkit-transform:scaleX(0);transform:scaleX(0);-webkit-transform-origin:0;transform-origin:0;transition-property:-webkit-transform;transition-property:transform;transition-property:transform,-webkit-transform;transition-timing-function:linear;z-index:99998}.fancybox-close-small{background:transparent;border:0;border-radius:0;color:#ccc;cursor:pointer;opacity:.8;padding:8px;position:absolute;right:-12px;top:-44px;z-index:401}.fancybox-close-small:hover{color:#fff;opacity:1}.fancybox-slide--html .fancybox-close-small{color:currentColor;padding:10px;right:0;top:0}.fancybox-slide--image.fancybox-is-scaling .fancybox-content{overflow:hidden}.fancybox-is-scaling .fancybox-close-small,.fancybox-is-zoomable.fancybox-can-pan .fancybox-close-small{display:none}.fancybox-navigation .fancybox-button{background-clip:content-box;height:100px;opacity:0;position:absolute;top:calc(50% - 50px);width:70px}.fancybox-navigation .fancybox-button div{padding:7px}.fancybox-navigation .fancybox-button--arrow_left{left:0;padding:31px 26px 31px 6px}.fancybox-navigation .fancybox-button--arrow_right{padding:31px 6px 31px 26px;right:0}.fancybox-caption{bottom:0;color:#eee;font-size:14px;font-weight:400;left:0;line-height:1.5;padding:25px 44px;right:0;text-align:center;z-index:99996}.fancybox-caption:before{background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAD6CAQAAADKSeXYAAAAYklEQVQoz42RwQ3AMAgDjfcfup8WoRykfBAK5mQHKSz5rbXJPis1hjiV3CIqgG0hLZPkVkA4p4x5oR1bVeDrdCLrW2Q0D5bcwY3TGMHbdw3mPRuOtaspYP1w//G1OIcW148H0DMCqI/3mMMAAAAASUVORK5CYII=);background-repeat:repeat-x;background-size:contain;bottom:0;content:"";display:block;left:0;pointer-events:none;position:absolute;right:0;top:-44px;z-index:-1}.fancybox-caption a,.fancybox-caption a:link,.fancybox-caption a:visited{color:#ccc;text-decoration:none}.fancybox-caption a:hover{color:#fff;text-decoration:underline}.fancybox-loading{-webkit-animation:a 1s linear infinite;animation:a 1s linear infinite;background:transparent;border:4px solid #888;border-bottom-color:#fff;border-radius:50%;height:50px;left:50%;margin:-25px 0 0 -25px;opacity:.7;padding:0;position:absolute;top:50%;width:50px;z-index:99999}@-webkit-keyframes a{to{-webkit-transform:rotate(1turn);transform:rotate(1turn)}}@keyframes a{to{-webkit-transform:rotate(1turn);transform:rotate(1turn)}}.fancybox-animated{transition-timing-function:cubic-bezier(0,0,.25,1)}.fancybox-fx-slide.fancybox-slide--previous{opacity:0;-webkit-transform:translate3d(-100%,0,0);transform:translate3d(-100%,0,0)}.fancybox-fx-slide.fancybox-slide--next{opacity:0;-webkit-transform:translate3d(100%,0,0);transform:translate3d(100%,0,0)}.fancybox-fx-slide.fancybox-slide--current{opacity:1;-webkit-transform:translateZ(0);transform:translateZ(0)}.fancybox-fx-fade.fancybox-slide--next,.fancybox-fx-fade.fancybox-slide--previous{opacity:0;transition-timing-function:cubic-bezier(.19,1,.22,1)}.fancybox-fx-fade.fancybox-slide--current{opacity:1}.fancybox-fx-zoom-in-out.fancybox-slide--previous{opacity:0;-webkit-transform:scale3d(1.5,1.5,1.5);transform:scale3d(1.5,1.5,1.5)}.fancybox-fx-zoom-in-out.fancybox-slide--next{opacity:0;-webkit-transform:scale3d(.5,.5,.5);transform:scale3d(.5,.5,.5)}.fancybox-fx-zoom-in-out.fancybox-slide--current{opacity:1;-webkit-transform:scaleX(1);transform:scaleX(1)}.fancybox-fx-rotate.fancybox-slide--previous{opacity:0;-webkit-transform:rotate(-1turn);transform:rotate(-1turn)}.fancybox-fx-rotate.fancybox-slide--next{opacity:0;-webkit-transform:rotate(1turn);transform:rotate(1turn)}.fancybox-fx-rotate.fancybox-slide--current{opacity:1;-webkit-transform:rotate(0deg);transform:rotate(0deg)}.fancybox-fx-circular.fancybox-slide--previous{opacity:0;-webkit-transform:scale3d(0,0,0) translate3d(-100%,0,0);transform:scale3d(0,0,0) translate3d(-100%,0,0)}.fancybox-fx-circular.fancybox-slide--next{opacity:0;-webkit-transform:scale3d(0,0,0) translate3d(100%,0,0);transform:scale3d(0,0,0) translate3d(100%,0,0)}.fancybox-fx-circular.fancybox-slide--current{opacity:1;-webkit-transform:scaleX(1) translateZ(0);transform:scaleX(1) translateZ(0)}.fancybox-fx-tube.fancybox-slide--previous{-webkit-transform:translate3d(-100%,0,0) scale(.1) skew(-10deg);transform:translate3d(-100%,0,0) scale(.1) skew(-10deg)}.fancybox-fx-tube.fancybox-slide--next{-webkit-transform:translate3d(100%,0,0) scale(.1) skew(10deg);transform:translate3d(100%,0,0) scale(.1) skew(10deg)}.fancybox-fx-tube.fancybox-slide--current{-webkit-transform:translateZ(0) scale(1);transform:translateZ(0) scale(1)}@media (max-height:576px){.fancybox-caption{padding:12px}.fancybox-slide{padding-left:6px;padding-right:6px}.fancybox-slide--image{padding:6px 0}.fancybox-close-small{right:-6px}.fancybox-slide--image .fancybox-close-small{background:#4e4e4e;color:#f2f4f6;height:36px;opacity:1;padding:6px;right:0;top:0;width:36px}}.fancybox-share{background:#f4f4f4;border-radius:3px;max-width:90%;padding:30px;text-align:center}.fancybox-share h1{color:#222;font-size:35px;font-weight:700;margin:0 0 20px}.fancybox-share p{margin:0;padding:0}.fancybox-share__button{border:0;border-radius:3px;display:inline-block;font-size:14px;font-weight:700;line-height:40px;margin:0 5px 10px;min-width:130px;padding:0 15px;text-decoration:none;transition:all .2s;-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;white-space:nowrap}.fancybox-share__button:link,.fancybox-share__button:visited{color:#fff}.fancybox-share__button:hover{text-decoration:none}.fancybox-share__button--fb{background:#3b5998}.fancybox-share__button--fb:hover{background:#344e86}.fancybox-share__button--pt{background:#bd081d}.fancybox-share__button--pt:hover{background:#aa0719}.fancybox-share__button--tw{background:#1da1f2}.fancybox-share__button--tw:hover{background:#0d95e8}.fancybox-share__button svg{height:25px;margin-right:7px;position:relative;top:-1px;vertical-align:middle;width:25px}.fancybox-share__button svg path{fill:#fff}.fancybox-share__input{background:transparent;border:0;border-bottom:1px solid #d7d7d7;border-radius:0;color:#5d5b5b;font-size:14px;margin:10px 0 0;outline:none;padding:10px 15px;width:100%}.fancybox-thumbs{background:#ddd;bottom:0;display:none;margin:0;-webkit-overflow-scrolling:touch;-ms-overflow-style:-ms-autohiding-scrollbar;padding:2px 2px 4px;position:absolute;right:0;-webkit-tap-highlight-color:transparent;top:0;width:212px;z-index:99995}.fancybox-thumbs-x{overflow-x:auto;overflow-y:hidden}.fancybox-show-thumbs .fancybox-thumbs{display:block}.fancybox-show-thumbs .fancybox-inner{right:212px}.fancybox-thumbs__list{font-size:0;height:100%;list-style:none;margin:0;overflow-x:hidden;overflow-y:auto;padding:0;position:absolute;position:relative;white-space:nowrap;width:100%}.fancybox-thumbs-x .fancybox-thumbs__list{overflow:hidden}.fancybox-thumbs-y .fancybox-thumbs__list::-webkit-scrollbar{width:7px}.fancybox-thumbs-y .fancybox-thumbs__list::-webkit-scrollbar-track{background:#fff;border-radius:10px;box-shadow:inset 0 0 6px rgba(0,0,0,.3)}.fancybox-thumbs-y .fancybox-thumbs__list::-webkit-scrollbar-thumb{background:#2a2a2a;border-radius:10px}.fancybox-thumbs__list a{-webkit-backface-visibility:hidden;backface-visibility:hidden;background-color:rgba(0,0,0,.1);background-position:50%;background-repeat:no-repeat;background-size:cover;cursor:pointer;float:left;height:75px;margin:2px;max-height:calc(100% - 8px);max-width:calc(50% - 4px);outline:none;overflow:hidden;padding:0;position:relative;-webkit-tap-highlight-color:transparent;width:100px}.fancybox-thumbs__list a:before{border:6px solid #ff5268;bottom:0;content:"";left:0;opacity:0;position:absolute;right:0;top:0;transition:all .2s cubic-bezier(.25,.46,.45,.94);z-index:99991}.fancybox-thumbs__list a:focus:before{opacity:.5}.fancybox-thumbs__list a.fancybox-thumbs-active:before{opacity:1}@media (max-width:576px){.fancybox-thumbs{width:110px}.fancybox-show-thumbs .fancybox-inner{right:110px}.fancybox-thumbs__list a{max-width:calc(100% - 10px)}}

.user-content img,
.user-content iframe {
	max-width: 100%;
	height: auto !important;
}

{# /* // Form and info */ #}

.fixed-product-form {
  position: fixed;
  bottom: 0;
  left: 0;
  z-index: 100;
  width: 100%;
  padding: 20px 20px 0 20px;
  border-radius: 20px 20px 0 0;
  @include prefix(transition, opacity 0.5s ease, webkit ms moz o);
}

.product-description{
  position: relative;
  max-height: 150px;
  overflow: hidden;
  &-more {
    position: absolute;
    bottom: 0;
    width: 100%;
    height: 40px;
  }
  &-full {
    max-height: fit-content;
    padding-bottom: 20px;
  }
}

.social-share-button {
  display: inline-block;
  margin-right: 15px;
  font-size: 22px;
  &:hover,
  &:focus{
    opacity: 0.8;
  }
}

.label-top-left {
  top: 25px;
  left: 25px;
  z-index: 2;
}

.product-image-limited {
  max-height: 320px;
  max-width: 100%;
  object-fit: contain;
}

{#/*============================================================================
  #Cart detail
==============================================================================*/#}

{# /* // Body */ #}

.modal-cart .modal-header {
  padding: 20px 20px 0 20px;
}
.cart-row {
  padding: 0 20px;
  &-items {
    position: relative;
    z-index: 10;
    margin-bottom: -20px;
    padding-bottom: 20px;
    border-radius: 0 0 10px 10px;
  }
  &-shipping {
    margin-left: -5px;
    margin-right: -5px;
    .cart-shipping-container {
      margin-top: -1px;
      padding: 50px 0 80px 0;
      border-radius: 0 0 10px 10px;
    }
  }
}

.cart-fixed-totals {
  z-index: 101;
  margin-top: -30px;
  padding: 20px;
  border-radius: 20px 20px 0 0;
  @include prefix(box-shadow, 0px -4px 3px rgba(50, 50, 50, 0.1), webkit ms moz);
  cursor: pointer;
}

.cart-item{
  &-info-container {
    margin: 15px 0;
  }
  &-image-container {
    position: absolute;
    width: calc(100% - 15px);
    height: 100%;
    overflow: hidden;
    .cart-item-image{
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
  }
  .fa-cog{
    display: none;
  }
  &-quantity {
    width: 100px;
  }
  &-spinner{
    display: inline-block;
    width: 100px;
    text-align: center;
  }
}

.total-promotions-row {
  display: flex;
}

.cart-promotion-detail,
.cart-promotion-number{
  -ms-flex-preferred-size: 0;
  flex-basis: 0;
  -ms-flex-positive: 1;
  flex-grow: 1;
  max-width: 100%;
  text-transform: uppercase;
}

.cart-promotion-number{
  text-align: right;
  font-weight: bold;
}

{#/*============================================================================
  #Media queries
==============================================================================*/ #}

{# /* // Min width 768px */ #}

@media (min-width: 768px) { 

  {# /* //// Components */ #}

  {# /* Modals */ #}

  .modal{
    &-bottom-sheet {
      left: 0;
      height: auto;
      margin: 0;
    }
    &-centered{
      height: auto;
      width: 80%;
      max-height: 80%;
      left: 10%;
      margin: 5% auto;
      &-small{
        left: 50%;
        width: 30%;
        height: auto;
        max-height: 80%;
        margin: 0;
      }
      &-md {
        top: 100%;
        bottom: 0;
        left: 50%;
        transform: translate(-50%, -50%);
        &.modal-show {
          left: 50%;
          transform: translateX(-50%);
          &.modal-bottom-md,
          &.modal-bottom {
            top: 50%;
            bottom: auto;
            left: 50%;
            height: 100%;
            transform: translate(-50%, -50%);
          }
        }
      }
      &-md-600px {
        width: 600px;
      }
    }
    &-bottom {
      @include border-radius;
    }
    &-docked-md{
      width: 500px;
      overflow-x: hidden;
      border-radius: 10px 0 0 10px;
    }
    &-docked-small{
      width: 350px;
    }
    &-close {
      margin-bottom: 0;
    }
    &-quickshop {
      left: 265px;
      margin-bottom: -30px;
      padding: 20px 280px 20px 20px;
      overflow: initial;
      .modal-header {
        top: 0;
        right: 270px;
        width: 60px;
        height: 40px;
        padding: 10px;
      }
    }
    &-md-width-400px {
      width: 400px;
      max-width: 90vw;
    }
  }

  .fancybox-slide--html .fancybox-content{
    width: 85%;
    height: auto;
    padding: 44px;
  }

  {# /*  Notifications */ #}

  .notification-floating .notification{
    width: 350px;
  }

  {# /* Filters */ #}

  .filter-input-price-container {
    width: 100px;
    .filter-input-price {
      padding: 11px;
    }
  }

  {# /* Tabs */ #}

  .tab-group{
    width: calc(100% + 20px);
    overflow-x: auto;
    white-space: normal;
    .tab{
      float: left;
      margin-right: 10px;
    }
  }

  {# /* //// Nav */ #}

  .nav-account {
    width: 90%;
  }

  {# /* //// Home */ #}

  .section-brands-home {
    padding-top: 95px;
  }

  .instafeed-card {
    padding-bottom: 92%;
    &-full {
      margin: 0;
      padding-bottom: initial;
    }
  }

  .section-category-home-background,
  .section-products-related-background,
  .section-account-background {
    left: -16px;
    width: calc(100% + 32px);
  }
  .section-products-related-background {
    left: 0;
    width: 100%;
  }

}

/* // Max width 767px */

@media (max-width: 767px) {
  .product-image-limited {
    max-height: 210px;
  }
}

{#/*============================================================================
  #Critical path utilities
==============================================================================*/#}

.visible-when-content-ready{
  visibility: visible!important;
}
.display-when-content-ready{
  display: block!important;
}
