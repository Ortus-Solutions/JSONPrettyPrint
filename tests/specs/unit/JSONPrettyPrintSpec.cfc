component extends="testbox.system.BaseSpec" {

    function run() {
        describe( 'JSONPrettyPrint', function() {
            var JSONPrettyPrint = new root.models.JSONPrettyPrint();
            var dataPath = expandPath( '/tests/specs/unit/data/' );
            var srcJSON = fileRead( '#dataPath#test.json' );

            it( 'formats JSON using the appropriate printer for the current CFML engine', function() {
                var formatted = JSONPrettyPrint.formatJson( srcJSON );
                expect( formatted.trim() ).toBe( fileRead( '#dataPath#baseformat.json' ).trim() );
            } );

            it( 'supports customizing the indent string', function() {
                var formatted = JSONPrettyPrint.formatJson( json = srcJSON, indent = chr( 9 ) );
                expect( formatted.trim() ).toBe( fileRead( '#dataPath#tabindent.json' ).trim() );
            } );

            it( 'supports putting spaces after colons', function() {
                var formatted = JSONPrettyPrint.formatJson( json = srcJSON, spaceAfterColon = true );
                expect( formatted.trim() ).toBe( fileRead( '#dataPath#colonspaced.json' ).trim() );
            } );

            it( 'supports sorting object keys', function() {
                var formatted = JSONPrettyPrint.formatJson( json = srcJSON, sortKeys = 'text' );
                expect( formatted.trim() ).toBe( fileRead( '#dataPath#sortedkeys.json' ).trim() );
            } );

            it( 'suppports customizing the line ending', function() {
                var formatted = JSONPrettyPrint.formatJson(
                    json = srcJSON,
                    indent = '',
                    lineEnding = '',
                    sortKeys = 'text'
                );
                expect( formatted.trim() ).toBe( fileRead( '#dataPath#nonewlines.json' ).trim() );
            } );

            it( 'makes both printers available for use (at your own risk on ACF)', function() {
                var formatted = JSONPrettyPrint.getCFMLPrinter().formatJson( srcJSON );
                // expect( isJSON( formatted ) ).toBeTrue();
                formatted = JSONPrettyPrint.getJSONPrinter().formatJson( srcJSON );
                // expect( isJSON( formatted ) ).toBeTrue();
            } );
        } );
    }


}
