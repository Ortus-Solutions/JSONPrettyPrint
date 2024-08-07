component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {

    function run() {
        describe( 'JSONPrettyPrint', function() {
            var dataPath = expandPath( '/tests/specs/unit/data/' );
            var srcJSON = fileRead( '#dataPath#test.json' );

            it( 'formats JSON using the appropriate printer for the current CFML engine', function() {
                var JSONPrettyPrint = getInstance( 'JSONPrettyPrint' );
                var formatted = JSONPrettyPrint.formatJson( srcJSON );
                expect( formatted.trim() ).toBe( fileRead( '#dataPath#baseformat.json' ).trim() );
            } );

            it( 'supports customizing the indent string', function() {
                var JSONPrettyPrint = getInstance( 'JSONPrettyPrint' );
                var formatted = JSONPrettyPrint.formatJson( json = srcJSON, indent = chr( 9 ) );
                expect( formatted.trim() ).toBe( fileRead( '#dataPath#tabindent.json' ).trim() );
            } );

            it( 'supports putting spaces after colons', function() {
                var JSONPrettyPrint = getInstance( 'JSONPrettyPrint' );
                var formatted = JSONPrettyPrint.formatJson( json = srcJSON, spaceAfterColon = true );
                expect( formatted.trim() ).toBe( fileRead( '#dataPath#colonspaced.json' ).trim() );
            } );

            it( 'supports sorting object keys', function() {
                var JSONPrettyPrint = getInstance( 'JSONPrettyPrint' );
                var formatted = JSONPrettyPrint.formatJson( json = srcJSON, sortKeys = 'text' );
                expect( formatted.trim() ).toBe( fileRead( '#dataPath#sortedkeys.json' ).trim() );
            } );

            it( 'suppports customizing the line ending', function() {
                var JSONPrettyPrint = getInstance( 'JSONPrettyPrint' );
                var formatted = JSONPrettyPrint.formatJson(
                    json = srcJSON,
                    indent = '',
                    lineEnding = '',
                    sortKeys = 'text'
                );
                expect( formatted.trim() ).toBe( fileRead( '#dataPath#nonewlines.json' ).trim() );
            } );

            it( 'supports ANSI output', function() {
                var JSONPrettyPrint = getInstance( 'JSONPrettyPrint' );
                var ansiColors = {
                    constant: chr( 27 ) & '[38;5;9m',
                    key: chr( 27 ) & '[38;5;14m',
                    number: chr( 27 ) & '[38;5;12m',
                    string: chr( 27 ) & '[38;5;10m'
                };
                var formatted = JSONPrettyPrint.formatJson( json = srcJSON, ansiColors = ansiColors );
                expect( formatted.trim() ).toBe( fileRead( '#dataPath#ansi.txt' ).trim() );
            } );

            it( 'makes both printers available for use (at your own risk on ACF)', function() {
                var JSONPrettyPrint = getInstance( 'JSONPrettyPrint' );
                var formatted = JSONPrettyPrint.getCFMLPrinter().formatJson( srcJSON );
                expect( isJSON( formatted ) ).toBeTrue();
                formatted = JSONPrettyPrint.getJSONPrinter().formatJson( srcJSON );
                expect( isJSON( formatted ) ).toBeTrue();
            } );

            it( 'correctly escapes object keys with both printers', function() {
                var JSONPrettyPrint = getInstance( 'JSONPrettyPrint' );
                var srcJSON = '{"a\\b":1}';

                var formatted = JSONPrettyPrint.getCFMLPrinter().formatJson( json = srcJSON, indent = '', lineEnding = '' );
                expect( formatted ).toBe( '{"a\\b":1}' );
                formatted = JSONPrettyPrint.getJSONPrinter().formatJson( json = srcJSON, indent = '', lineEnding = '' );
                expect( formatted ).toBe( '{"a\\b":1}' );
            } );

            it( 'supports formatting queries', function() {
                var testQuery = queryNew( 'id', 'integer', [ [ 1 ], [ 2 ], [ 3 ] ] );
                var obj = { 'testQuery': testQuery };
                var JSONPrettyPrint = getInstance( 'JSONPrettyPrint' );
                var formatted = JSONPrettyPrint.getCFMLPrinter().formatJson( json = obj, sortKeys = 'textnocase' );
                expect( formatted.trim() ).toBe( fileRead( '#dataPath#queryformat.json' ).trim() );
            } );
        } );
    }


}
