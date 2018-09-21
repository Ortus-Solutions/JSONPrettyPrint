component extends="testbox.system.BaseSpec" {

    function run() {
        describe( 'The JSON parser', function() {
            var parser = new root.models.JSONSimpleParser();
            var dataPath = expandPath( '/tests/specs/unit/data/' );

            it( 'fails correctly on invalid JSON', function() {
                var srcJSON = fileRead( '#dataPath#invalid.json' );
                expect( function() {
                    parser.parse( srcJSON );
                } ).toThrow( regex = 'Unable to parse JSON' );
            } );

            it( 'handles string escapes correctly', function() {
                var srcJSON = fileRead( '#dataPath#string.json' );
                var parsed = parser.parse( srcJSON );
                expect( parsed.elements.len() ).toBe( 1 );
                expect( parsed.elements[ 1 ].value.end ).toBe( 15 );
            } );
        } );
    }

}
