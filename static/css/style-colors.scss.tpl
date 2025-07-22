{#/*============================================================================
style.scss.tpl

    -This file contains all the theme styles related to settings defined by user from config/settings.txt
    -Rest of styling can be found in:
      --static/css/style-async.css.tpl --> For non critical styles witch will be loaded asynchronously
      --static/css/style-critical.tpl --> For critical CSS rendered inline before the rest of the site

==============================================================================*/#}

{# /*============================================================================
  Table of Contents

  #Colors and fonts
    // Colors
    // Font families
    // Icons
    // Texts
    // Borders
  #Components
    // Margin and padding
    // Mixins
    // Animations
    // Functions
    // Wrappers
    // Placeholders
    // Dividers
    // Breadcrumbs
    // Headings
    // Buttons
    // Links
    // Progress bar
    // Chips
    // Modals
    // Forms
    // Alerts and notifications
    // Tables
    // Tabs
    // Cards
    // Sliders
  #Home page
    // Home slider
    // Home banners
    // Brands
    // Video
    // Instafeed
    // Featured products
    // Sections
  #Product grid
    // Grid item
    // Labels
    // Filters
  #Product detail
    // Image
    // Form and info
  #Cart detail
  #Contact page
    // Data contact
  #Account page
    // Order items
  #Header and nav
    // Ad Bar
    // Header
    // Search
  #Footer
  #Media queries
    // Forms

==============================================================================*/ #}

{#/*============================================================================
  #Colors and fonts
==============================================================================*/#}
	
{# /* // Colors */ #}

$primary-color: {{ settings.primary_color }};
$positive-color: {{ settings.positive_color }};
$negative-color: {{ settings.negative_color }};
$accent-color: {{ settings.accent_color }};

{# /* // Font families */ #}

$heading-font: {{ settings.font_headings | raw }};
$body-font: {{ settings.font_rest | raw }};

{# /* // Icons */ #}

.svg-icon-primary{
  fill: $primary-color;
}
.svg-icon-text{
  fill: $positive-color;
  &.svg-circle{
    border: 1px solid $positive-color;
  }
}
.svg-icon-accent{
  fill: $accent-color;
}
.svg-icon-invert{
  fill: $negative-color;
  &.svg-circle{
    border: 1px solid $negative-color;
  }
}

{# /* // Texts */ #}

.text-primary {
  color: $primary-color;
}

.text-secondary {
  color: $negative-color;
}

.text-accent {
  color: $accent-color;
}

{# /* // Borders */ #}

%border-radius {
  border-radius: 10px;
}

{#/*============================================================================
  #Components
==============================================================================*/#}

{# /* // Margin and padding */ #}

%section-margin {
  margin-bottom: 70px;
}
%element-margin {
  margin-bottom: 20px;
}
%element-margin-half {
  margin-bottom: 10px;
}

{# /* // Mixins */ #}

@mixin text-decoration-none(){
  text-decoration: none;
  outline: 0;
  &:hover,
  &:focus{
    text-decoration: none;
    outline: 0;
  }
}

@mixin no-wrap(){
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	font-weight: normal;
}

@mixin drop-shadow(){
	-moz-box-shadow: 0 0 3px #ccc;
	-webkit-box-shadow: 0 0 3px #ccc;
	box-shadow: 0 0 3px #ccc;
}

{# This mixin adds browser prefixes to a CSS property #}

@mixin prefix($property, $value, $prefixes: ()) {
	@each $prefix in $prefixes {
    	#{'-' + $prefix + '-' + $property}: $value;
	}
   	#{$property}: $value;
}

{# /* // Animations */ #}

%simplefade {
  transition: all 0.5s ease;
}

{# /* // Functions */ #}

@function set-foreground-color($bg-color, $foreground-color) {
  @if (lightness($bg-color) > 50) {
    @return $foreground-color; // Lighter backgorund, return dark color
  } @else {
    @return lighten($foreground-color, 15%); // Darker background, return light color
  }
}

{# /* // Wrappers */ #}

%body-font {
  font-size: 14px;
}

body{
  color: $positive-color;
  font-family: $body-font;
  background-color:$negative-color;
  @extend %body-font;
}

.box {
  width: 100%;
  margin-bottom: 20px;
  padding: 20px;
  border: 1px solid rgba($positive-color, .2);
  @extend %border-radius;
}

.container-invert {
  $container-invert-foreground: rgba($negative-color, .5);
  background-color: $positive-color;
  color: $negative-color;
  fill: $negative-color;
  a,
  .btn-link-capitalize {
    color: $negative-color;
    fill: $negative-color;
    &:focus,
    &:hover {
      color: rgba($negative-color, .6);
      fill: rgba($negative-color, .6);
    }
  }
  .btn-default {
    background: rgba($negative-color, .4);
    border: 1px solid rgba($negative-color, .3);
    border-left: 0;
  }
  .btn-link {
    color: $negative-color;
  }
  .form-control,
  .form-select {
    color: $negative-color;
    background: transparent;
    border-color: $container-invert-foreground;
  }
  .form-select-icon,
  .form-quantity-icon {
    background: $positive-color;
    .svg-icon-text {
      fill: $negative-color;
    }
  }
  .form-control::-webkit-input-placeholder { 
    color: $container-invert-foreground;
  }
  .form-control:-moz-placeholder {
    color: $container-invert-foreground;
  }
  .form-control::-moz-placeholder {
    color: $container-invert-foreground;
  }
  .form-control:-ms-input-placeholder {
    color: $container-invert-foreground;
  }
  .box {
    border-color: $container-invert-foreground;
  }
  .text-primary {
    color: $primary-color;
  }
  .spinner::before {
    background-color: $negative-color;
  }
  .table{
    background-color: $positive-color;
    color: $negative-color;
    tbody{
      tr:nth-child(odd){
        background-color: rgba($negative-color, .08);
      }
    }
  }
  .alert:before {
    background-color: $positive-color;
  }
}

{# /* // Placeholders */ #}

.placeholder-container{
  background-color:lighten($positive-color, 80%);
}
.placeholder-color{
  background-color:rgba($positive-color, 0.07);
}
.placeholder-icon svg{
  fill:rgba($positive-color, 0.2);
}
.placeholder-shine,
.placeholder-fade,
.placeholder-overlay{
  background-color:rgba($positive-color, 0.2);
}

.placeholder-overlay-invert {
  color: $negative-color;
  fill: $negative-color;
}

.placeholder-info {
  color: $negative-color;
  fill: $negative-color;
  background-color: $positive-color;
  box-shadow: 0 1px 3px rgba(0,0,0,0.5);
}

.spinner::before {
  background-color: $positive-color;
}

{# /* // Dividers */ #}

.divider{
  margin-top: 20px;
  margin-bottom: 20px;
  clear: both;
  border-bottom: 1px solid rgba($positive-color, .1);
}

{# /* // Breadcrumbs */ #}

.breadcrumbs {
  @extend %element-margin;
}

{# /* Headings */ #}

h1,.h1,
h2,.h2,
h3,.h3,
h4,.h4,
h5,.h5,
h6,.h6{
  margin-top: 0;
  font-family: $heading-font;
}

.h-font-body{
  font-family: $body-font;
}

.page-header {
  background: $negative-color;
  @extend %element-margin;
  h1, .h1{
    margin-bottom: 0;
  }
  &-invert {
    background: $positive-color;
  }
}

{# /* // Buttons */ #}

.btn{
  padding: 17px 15px;
  text-decoration: none;
  text-align: center;
  border: 0;
  cursor: pointer;
  text-transform: uppercase;
  background: none;
  @extend %border-radius;
  @include prefix(appearance, none, webkit ms moz o);
  @include prefix(transition, all 0.4s ease, webkit ms moz o);
  &:hover,
  &:focus{
    outline: 0;
    opacity: 0.8;
  }
  &[disabled],
  &.disabled,
  &[disabled]:hover,
  &.disabled:hover,{
    opacity: 0.3;
    cursor: not-allowed;
    outline: 0;
  }
  &-default{
    background-color: rgba($positive-color, .3);
    color: $negative-color;
    fill: $negative-color;
    font-size: 12px;
    letter-spacing: 4px;
  }
  &-primary{
    background-color: $primary-color;
    color: $negative-color;
    fill: $negative-color;
    letter-spacing: 4px;
    @extend %body-font;
    &:hover{
      color: $negative-color;
      fill: $negative-color;
    }
    .spinner::before {
      background-color: $negative-color;
    }
    {% if settings.primary_color_gradient %}
      background:linear-gradient(to right, adjust-hue($primary-color, -30%), $primary-color);
      background-size: 100%;
      @include prefix(transition, background 1s ease, webkit ms moz o);
      &:hover,
      &:focus {
        opacity: 1;
        background-size: 200%;
      }
    {% endif %}
  }
  &-secondary{
    background-color: $negative-color;
    color: $positive-color;
    fill: $positive-color;
    border: 1px solid $positive-color;
  }
  &-block{
    width: 100%;
  }
  &-medium{
    padding: 12px;
  }
  &-small{
    display: inline-block;
    padding: 10px;
    font-size: 10px;
    letter-spacing: 2px;
  }
  &-circle{
    height: 32px;
    border-radius: 50%;
  }
  &-variant{
    display: inline-block;
    min-width: 36px;
    min-height: 36px;
    margin: 0 5px 10px 0;
    padding: 2px;
    font-size: 14px;
    line-height: 10px;
    border: 1px solid rgba($positive-color, .6);
    color: rgba($positive-color, .8);
    vertical-align: top;
    text-transform: none;
    &-content{
      display: block;
      min-height: 22px;
      margin: 4px;
      padding: 0 4px;
      line-height: 22px;
      border-radius: 4px;
      &-square {
        position: relative;
        width: 46px;
        height: 46px;
        overflow: hidden;
      }
    }
    &.selected {
      color: $positive-color;
      border: 1px solid $positive-color;
      background: rgba($positive-color, .1);
    }
    &-no-stock {
      position: relative;
      background: transparent;
      color: rgba($positive-color, 0.5);
      border-color: rgba($positive-color, 0.3);
      overflow: hidden;
      &:after {
        position: absolute;
        top: 0;
        left: 0;
        z-index: 9;
        width: 100%;
        height: 100%;
        background: linear-gradient(to top left,transparent 49%,rgba($positive-color, 0.5) ,transparent 52%);
        content:'';
      }

      &.selected:after {
        background: linear-gradient(to top left,transparent 49%,$positive-color ,transparent 52%);
      }

      &.btn-variant-color:after {
        background: linear-gradient(-45deg,rgba($negative-color, 0.3) calc(50% - .7px),rgba($positive-color, 0.5) calc(50% - .7px),rgba($positive-color, 0.5) 50%,rgba($positive-color, 0.5) calc(50% + .7px),rgba($negative-color, 0.3) calc(50% + .7px));
      }

      &.btn-variant-color.selected:after {
        background: linear-gradient(-45deg,rgba($negative-color, 0.3) calc(50% - .7px),$positive-color calc(50% - .7px),$positive-color 50%,$positive-color calc(50% + .7px),rgba($negative-color, 0.3) calc(50% + .7px));
      }
    }
  }
  &-facebook{
    background-color: #1977f2;
    .svg-fb-icon {
      fill: #fff;
    }
  }
  &-stroke-gradient{
    letter-spacing: 4px;
    text-transform: uppercase;
    &:after,
    &:before {
      position: absolute;
      top: 0;
      right: 0;
      bottom: 0;
      left: 0;
      content:'';
      margin: auto;
      border-radius: 10px;
    }
    &:after{
      z-index: -2;
      width: 100%;
      height: 100%;
      background: linear-gradient(to right, adjust-hue($primary-color, -30%), $primary-color);
      border-radius: 10px;
    }
    &:before {
      z-index: -1;
      width: calc(100% - 2px);
      height: calc(100% - 2px);
      background: $positive-color;
    }
  }
}

button{
  @extend %body-font;
  cursor: pointer;
  &:focus{
    outline: 0;
    opacity: 0.8;
  }
}

.container-invert .btn-variant {
  border: 1px solid rgba($negative-color, .6);
  color: rgba($negative-color, .8);
  &.selected {
    color: $negative-color;
    border: 1px solid $negative-color;
    background: rgba($negative-color, .1);
  }
  &-no-stock {
    color: rgba($negative-color, 0.5);
    border-color: rgba($negative-color, 0.3);
    &:after {
      background: linear-gradient(to top left,transparent 49%,rgba($negative-color, 0.5) ,transparent 52%);
    }
    &.selected:after {
      background: linear-gradient(to top left,transparent 49%,$negative-color ,transparent 52%);
    }
    &.btn-variant-color:after {
      background: linear-gradient(-45deg,rgba($positive-color, 0.3) calc(50% - .7px),rgba($negative-color, 0.5) calc(50% - .7px),rgba($negative-color, 0.5) 50%,rgba($negative-color, 0.5) calc(50% + .7px),rgba($positive-color, 0.3) calc(50% + .7px));
    }
    &.btn-variant-color.selected:after {
      background: linear-gradient(-45deg,rgba($positive-color, 0.3) calc(50% - .7px),$negative-color calc(50% - .7px),$negative-color 50%,$negative-color calc(50% + .7px),rgba($positive-color, 0.3) calc(50% + .7px));
    }
  }
}

{# /* // Links */ #}

a {
  color: $positive-color;
  fill: $positive-color;
  @include prefix(transition, all 0.4s ease, webkit ms moz o);
  &:hover,
  &:focus{
    color: rgba($positive-color, .5);
    fill: rgba($positive-color, .5);
  }
}

.link-contrast {
  color: $negative-color;
  fill: $negative-color;
  &:hover,
  &:focus{
    color: rgba($negative-color, .8);
    fill: rgba($negative-color, .8);
  }
}

.btn-link{
  color: $positive-color;
  fill: $primary-color;
  text-transform: uppercase;
  cursor: pointer;
  &:hover,
  &:focus{
    color: rgba($primary-color, .5);
    fill: rgba($primary-color, .5);
  }
}

.btn-link-capitalize {
  @extend .btn-link;
  font-size: 16px;
  text-transform: initial;
}

.btn-link-underline {
  @extend .btn-link-capitalize;
  padding: 5px;
  font-size: 14px;
  text-decoration: underline;
}

{# /* // Progress bar */ #}


.container-invert .bar-progress {
  outline: 1px solid $negative-color;
  &-active {
    background: $negative-color;
    &:after {
      background: $negative-color;
      box-shadow: 0 0 6px 0 rgba($positive-color, .5);
    }
  }
  &-icon {
    fill: $positive-color;
  }
}

.bar-progress {
  outline: 1px solid $primary-color;
  &-active {
    background: $primary-color;
    &:after {
      background: $primary-color;
      box-shadow: 0 0 6px 0 rgba($positive-color, .5);
    }
  }
  &-icon {
    fill: $negative-color;
  }
}

{# /* // Chips */ #}

.chip {
  background: none;
  color: $positive-color;
  border: 1px solid rgba($positive-color, .2);

  &-remove-icon {
    fill: $positive-color;
  }
}

{# /* // Modals */ #}

.modal{
  color: $positive-color;
  background-color:$negative-color;
  &-invert{
    color: $negative-color;
    background-color:$positive-color;
  }
  &-header{
    font-family: $heading-font;
  }
}

{# /* // Forms */ #}

input,
textarea,
.form-control:not(textarea) {
  font-family: $body-font;
  font-size: 16px;
}

.form-control {
  display: block;
  padding: 15px;
  width: 100%;
  font-size: 16px; /* Hack to avoid autozoom on IOS */
  border: 1px solid rgba($positive-color, .2);
  @extend %border-radius;
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  color: $positive-color;
  font-size: 14px;
  background-color: $negative-color;
  &:focus{
    outline: 0;
  }
  &-inline{
    display: inline;
  }
  &-quantity{
    padding: 15px 45px;
    text-align: center;
    &-small {
      padding: 6px 30px;
    }
  }
}

input::-webkit-inner-spin-button,
input::-webkit-outer-spin-button{
  -webkit-appearance: none;
  margin: 0;
}

input[type=number] {
  -moz-appearance:textfield;
}

.form-group-inline{
  .form-control{
    border-radius: 10px 0 0 10px;
  }
  .btn{
    border-radius: 0 10px 10px 0;
  }
}

.form-control::-webkit-input-placeholder { 
  color: rgba($positive-color, .3);
}
.form-control:-moz-placeholder {
  color: rgba($positive-color, .3);
}
.form-control::-moz-placeholder {
  color: rgba($positive-color, .3);
}
.form-control:-ms-input-placeholder {
  color: rgba($positive-color, .3);
}

.form-control.alert-danger {
  background-color: $negative-color;
  border-bottom: 1px solid #cc4845;
}

.form-select{
  display: block;
  min-height: 52px;
  padding: 15px;
  width: 100%;
  font-size: 16px; /* Hack to avoid autozoom on IOS */
  @extend %border-radius;
  border: 1px solid rgba($positive-color, .2);
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  color: $positive-color;
  background-color: $negative-color;
  @extend %body-font;
  &-icon{
    background: $negative-color;
  }
}

.input-clear-content:before {
  content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" fill="{{ settings.primary_color |replace("#","%23") }}"><path d="M174.41,256,320,401.59,305.59,416,160,270.4,14.41,416,0,401.59,145.6,256,0,110.41,14.43,96,160,241.59,305.59,96,320,110.41Z"/></svg>');
}

.radio-button-container{
  .radio-button {
    &-content{
      fill: $positive-color;
    }
    input[type="radio"]{
      &:checked {
        + .radio-button-content{
          color: $positive-color;
          fill: $positive-color;
          background-color: $negative-color;
          .unchecked{
            border: 10px solid $positive-color;
          }
          .checked{
            background-color: $negative-color;
          }
          a,
          .btn-link-capitalize {
            color: $positive-color;
            fill: $positive-color;
          }
        }
        .shipping-method-price{
          color: $primary-color;
        }
      }

      & +  .radio-button-content .unchecked{
        border: 10px solid $negative-color;
      }
      & +  .radio-button-content .checked{
        background-color: $positive-color;
      }
    }
  }
  .shipping-extra-options .radio-button-item:first-child {
    .radio-button-content{
      border-top: 1px solid rgba($positive-color, .1);
    }
    input[type="radio"]:checked .radio-button-content{
      border: 2px solid $primary-color;
    }
  }
}

.checkbox-container{
  .checkbox {
    color: $positive-color;
    border: 1px solid rgba($positive-color, .2);
    font-weight: lighter;
    &-color {
      border: 1px solid rgba($positive-color, .2);
    }
    &-icon {
      background: $negative-color;
      border: 1px solid $positive-color;
      &:after {
        border: solid $positive-color;
        border-width: 0 2px 2px 0;
      }
    }
    &:hover {
      color: rgba($positive-color,.8);
    }
  }
  input:checked ~ .checkbox {
    background-color: $positive-color;
    color: $negative-color;
    .checkbox {
      &-color {
        border: 1px solid rgba($negative-color, .4)
      }
    }
  }
}

{# /* // Alerts and notifications */ #}

.alert{
  &:after,
  &:before {
    position: absolute;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    content: '';
    margin: auto;
    @extend %border-radius;
  }
  &:before {
    width: calc(100% - 2px);
    height: calc(100% - 2px);
    z-index: -1;
    background: $negative-color;
  }
  &:after{
    width: 100%;
    height: 100%;
    z-index: -2;
  }
  &-danger,
  &-error{
    color: rgba(set-foreground-color($negative-color, #cc4845),100);
    &:after {
      background: linear-gradient(to right, rgba(set-foreground-color($negative-color, #cc4845),.5), rgba(set-foreground-color($negative-color, #fe3d3d),100));
    }
  }
  &-warning{
    &:after {
      background: linear-gradient(to right, rgba(set-foreground-color($negative-color, #c09853),.5), rgba(set-foreground-color($negative-color, #ffdd55),100));
    }
  }
  &-success{
    color: rgba(set-foreground-color($negative-color, #3caf65),100);
    &:after {
      background: linear-gradient(to right, rgba(set-foreground-color($negative-color, #3caf65),.5), rgba(set-foreground-color($negative-color, #4dc247),100));
    }
  }
  &-primary {
    &:after {
      background: linear-gradient(to right, adjust-hue($primary-color, -30%), $primary-color);
    }
  }
}

.notification-primary{
  color: $positive-color;
  fill: $positive-color;
  background-color: $negative-color;
}

.notification-invert{
  color: $negative-color;
  fill: $negative-color;
  background-color: $positive-color;
  &-footer {
    color: $positive-color;
    fill: $positive-color;
    background-color: $negative-color;
  }
}

.notification-secondary {
  background: darken($negative-color, 3%);
  color: rgba($positive-color, 100);
}

{# /* // Tables */ #}

.table{
  background-color: $negative-color;
  color: $positive-color;
  tbody{
    tr:nth-child(odd){
      background-color: rgba($positive-color, .05);
    }
    &.table-body-inverted{
      tr:nth-child(odd){
        background-color: $negative-color;
      }
      tr:nth-child(even){
        background-color: rgba($positive-color, .05);
      }
    }
  }
  th{
    padding: 8px;
    text-align: left;
  }
}

{# /* // Tabs */ #}

.tab{
  &-link,
  &-nav-link{
    color: $positive-color;
    border: 1px solid rgba($positive-color, .5);
    &-inverse {
      color: $negative-color;
      border: 1px solid $negative-color;
    }
  }
  &-active,
  &.active{
    .tab-link,
    .tab-nav-link{
      color: $negative-color;
      background: $primary-color;
      border-color: transparent;
      border-right: 0;
      border-left: 0;
      {% if settings.primary_color_gradient %}
        background:linear-gradient(to right, adjust-hue($primary-color, -30%), $primary-color);
        background-size: 100%;
        @include prefix(transition, background 1s ease, webkit ms moz o);
        &:hover,
        &:focus {
          opacity: 1;
          background-size: 200%;
        }
      {% endif %}
    }
  }
}

{# /* // Cards */ #}

.card-gray-scale {
  filter: grayscale(100%);
}

.card-invert {
  background: $negative-color;
  color: $positive-color;
  box-shadow: 2px 2px 6px rgba(0,0,0,0.2);
}

{# /* // Sliders */ #}

.swiper-text {
  @extend %simplefade;
}

.swiper-title {
  font-family: $heading-font;
}

.swiper-dark {
  color: $positive-color;
}

.swiper-light {
  color: $negative-color;
}

.swiper-pagination-bullet {
  border: 1px solid $positive-color;
  &-active {
    background-color: $positive-color;
  }
}

.swiper-pagination-white .swiper-pagination-bullet {
  background: transparent;
  border: 1px solid $negative-color;
  opacity: 1;
}
.swiper-pagination-white .swiper-pagination-bullet-active {
  background-color: $negative-color;
}

.swiper-overlay {
  background: rgba($positive-color, .2);
}

{#/*============================================================================
  #Home Page
==============================================================================*/#}

.template-home {
  background: $positive-color;
}

{# /* // Home slider */ #}

.section-slider {
  margin-bottom: 30px;
}

{# /* // Home banners */ #}

.textbanner-text {
  color: $negative-color;
}

.textbanner-image.overlay:after {
  background: rgba($positive-color, .2);
}

.textbanner-image.overlay:before {
  background: linear-gradient(180deg, transparent 60%, darken($positive-color, 10%) 100%);
}

.section-informative-banners {
  background: $negative-color;
}

{# /* // Brands */ #}

.section-brands-home {
  color: $negative-color;
}

{# /* // Video */ #}

.section-video-home {
  @extend %element-margin;
}

.embed-responsive {
  background: $positive-color;
}

{# /* // Instafeed */ #}

.section-instafeed-home {
  @extend %element-margin;
  .instafeed-card-full {
    background: $positive-color;
  }
}

{% if not settings.instagram_gradient %}
  .instafeed-card {
    background: $primary-color;
  }

  .instafeed-title {
    color: $negative-color;
    &:hover,
    &:focus {
      color: rgba($negative-color, .8);
    }
  }
{% endif %}

.instafeed-info {
  color: $negative-color;
  fill: $negative-color;
  background: rgba($positive-color, .6);
}

{# /* // Featured products */ #}

.section-featured-home,
.section-category-home-background,
.section-account-background,
.section-order-background {
  background: $negative-color;
}

{# /* // Sections */ #}

{% if not settings.positive_color_background %}
  .section-category-home + .section-video-home,
  .section-featured-home + .section-video-home,
  .section-informative-banners + .section-video-home,
  .section-category-home + .section-instafeed-home,
  .section-featured-home + .section-instafeed-home,
  .section-informative-banners + .section-instafeed-home {
    background: $negative-color;
  }
{% endif %}

.section-transparent {
  background: transparent;
}

{#/*============================================================================
  #Product grid
==============================================================================*/#}

{# /* // Grid item */ #}

.item-link {
  color: $positive-color;
}

.item-colors-bullet {
  color: $positive-color;
  background: $negative-color;
}

.item-colors-bullet-text {
  color: $negative-color;
  background: $positive-color;
}

.item-colors-text {
  color: $negative-color;
}

.item-installments { 
  color: $accent-color;
}

.item-product-card {
  background: $negative-color;
}

.item-btn-quickshop + .alert {
  color: $positive-color;
  &:hover {
    color: $positive-color;
  }
}

.item-image-link:hover .item-slider-controls-container{
  fill: $positive-color;
}

{# /* // Labels */ #}

.label {
  background: darken($negative-color, 5%);
  color: $negative-color;
  &.label-primary{
    background: $positive-color;
    color: $negative-color;
  }
  &.label-accent{
    background: $accent-color;
  }
  &.label-secondary{
    color: $positive-color;
  }
}

{# /* // Filters */ #}

.category-controls {
  background: $positive-color;
  border-radius: 10px 0 0 10px;
  @extend %simplefade;
  &.is-sticky {
    border-bottom: 1px solid rgba($positive-color, .1);
  }
}

.filters-overlay {
  background-color: rgba($negative-color, .85);
}

{#/*============================================================================
  #Product detail
==============================================================================*/#}

.template-product,
.template-account-orders,
.template-account-order {
  background: $positive-color;
}

{% if not settings.positive_color_background %}
  .product-detail-container {
    background: $negative-color;
  }
{% endif %}

{# /* // Image */ #}

.product-detail-slider {
  background: rgba($positive-color, 0.04);
}

.product-video-container {
  background-color: rgba($positive-color, .07);
}

.product-detail-back {
  background-color: $positive-color;
}

{# /* // Form and info */ #}

.fixed-product-form {
  background: $negative-color;
  @include prefix(box-shadow, 0 0 6px 0 rgba($positive-color, .2), webkit ms moz o);
}

.product-description-more {
  {% if settings.positive_color_background %}
    background:linear-gradient(to top, $positive-color, rgba($positive-color, .5));
    .btn-link {
      color: $negative-color;
    }
  {% else %}
    background:linear-gradient(to top, $negative-color, rgba($negative-color, .5));
  {% endif %}
}

.section-fb-comments {
  background: rgba($negative-color, .5);
  @extend %border-radius; 
}

.social-share {
  @extend %element-margin;
}

.section-products-related {
  background: $positive-color;
  &-background {
    background: $negative-color;
  }
}

{#/*============================================================================
  #Cart detail
==============================================================================*/#}

.cart-fixed-totals,
.cart-row-items {
  background-color: $negative-color;
}

{#/*============================================================================
  #Contact page
==============================================================================*/#}

{# /* // Data contact */ #}

.contact-item {
  @extend %element-margin;
}

.contact-link {
  color: $positive-color;
}

{#/*============================================================================
  #Account page
==============================================================================*/#}

{# /* // Order item */ #}

.order-item {
  padding: 15px 0;
  border-bottom: 1px solid rgba($positive-color, .08);
  &:first-child {
    border-top: 1px solid rgba($positive-color, .08);
  }
}

{#/*============================================================================
  #Header and nav
==============================================================================*/#}

{# /* // Ad Bar */ #}

.section-advertising {
  background-color: $primary-color;
  color: $negative-color;
}

{# /* // Header */ #}

.head-main{
  background-color: $negative-color;
  transition: all 0.1s ease;
  .svg-icon-text {
    color: $positive-color;
    fill: $positive-color;
  }
}

.hamburger-bar-1,
.hamburger-bar-2 {
  background: $positive-color;
}

.hamburger-close .hamburger-bar-1,
.hamburger-close .hamburger-bar-2 {
  background: $negative-color;
}

.head-transparent{
  background-color: transparent;
}

.cart-widget-amount {
  background: $primary-color;
}

.sidebar-content {
  color: $negative-color;
  background-color: $positive-color;
  &-transparent {
    color: $negative-color;
    background-color: transparent;
  }
}

.nav-list-link,
.sidebar-content .footer-menu-link,
.modal-invert .footer-menu-link {
  color: $negative-color;
  fill: $negative-color;
  &:hover,
  &:focus{
    color: rgba($negative-color, .8);
    fill: rgba($negative-color, .8);
  }
}

.nav-list > li > .nav-list-link {
  font-family: $heading-font;
}
.nav-list-panel {
  background-color:$positive-color;
}

.nav-account{
  background: rgba($negative-color, .2);
  &-link {
    color: $negative-color;
    &:hover,
    &:focus{
      color: rgba($negative-color, .8);
    }
    &-invert {
      color: $positive-color;
      &:hover,
      &:focus{
        color: rgba($positive-color, .8);
      }
    }
  }
  &-invert {
    background: $negative-color;
  }
}

{# /* // Search */ #}

.search-suggest-item {
  @include prefix(box-shadow, 0 0 6px 0 rgba($positive-color, .2), webkit ms moz o);
}

{#/*============================================================================
  #Footer
==============================================================================*/#}

footer {
  background: $negative-color;
}

.icon-logo,
.card-img {
  border: 1px solid rgba($positive-color, .2);
}

.footer-legal {
  background: rgba($positive-color, .1);
}

.powered-by-logo svg {
  fill: $positive-color;
}

{# /* // Newsletter */ #}

.newsletter-btn {
  color: $positive-color;
}

{#/*============================================================================
  #Media queries
==============================================================================*/ #}

{# /* // Min width 768px */ #}

@media (min-width: 768px) { 

  .sidebar-content-transparent {
    background-color: $positive-color;
  }

  {# /* Product grid */ #}

  .item-colors {
    &-bullet:not(.item-colors-bullet-text) {
      background-color: $negative-color;
      border: 1px solid rgba($positive-color, .5);
      &.selected {
        border: 1px solid $positive-color;
      }
    }
  }

  {# /* Forms */ #}

  input,
  textarea,
  .form-select,
  .form-control:not(textarea) {
    font-size: 14px;
  }

  .form-control-quantity {
    padding: 16px 45px;
  }
  .form-control-quantity-small {
    padding: 6px 30px;
  }

  .btn-small-md {
    padding: 17px 15px;
    font-size: 14px;
  }

}
