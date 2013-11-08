/**
 * @license Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
    config.allowedContent = true;
    config.protectedSource.push( /<a[\s\S]*?\/a>/g );
    config.protectedSource.push( /<article[\s\S]*?\>/g ); //allows beginning <i> tag
    config.protectedSource.push( /<\/article[\s\S]*?\>/g ); //allows ending </i> tag
};
