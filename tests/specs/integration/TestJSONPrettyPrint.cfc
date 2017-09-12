component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app" {
	
    function run() {
    
        describe( "Integration Specs", function() {
        	
            it( "can run integration specs with the module activated", function() {
                expect( getController().getModuleService().isModuleRegistered( "JSONPrettyPrint" ) ).toBeTrue();
            } );
            
        } );
    
        describe( "JSONPrettyPrint", function() {
        	
        	var JSONRegex = '\{[ \t]*[\r\n]{1,2}[ \t]*"foo"[ \t]*:[ \t]*"bar"[ \t]*[\r\n]{1,2}[ \t]*}';
        	
            it( "Can pretty print a JSON string", function() {
            	var JSONPrettyPrint = getInstance( 'JSONPrettyPrint' );
            	var formatted = JSONPrettyPrint.formatJSON( '{ "foo" : "bar" }' );
            	expect( formatted ).toMatch( JSONRegex );
            } );
        	
            it( "Can pretty print a JSON object", function() {
            	var JSONPrettyPrint = getInstance( 'JSONPrettyPrint' );
            	var formatted = JSONPrettyPrint.formatJSON( { "foo" : "bar" } );
     
            	expect( formatted ).toMatch( JSONRegex );

            } );
        	
            it( "Can customize indent chars", function() {
            	var JSONPrettyPrint = getInstance( 'JSONPrettyPrint' );
            	var formatted = JSONPrettyPrint.formatJSON( { "foo" : "bar" }, '	' );
     
            	expect( formatted ).toMatch( JSONRegex );

            } );
            
        	it( "Can customize line endings", function() {
            	var JSONPrettyPrint = getInstance( 'JSONPrettyPrint' );
            	var formatted = JSONPrettyPrint.formatJSON( json={ "foo" : "bar" }, indent='	', lineEnding=chr( 10 ) );
     
            	expect( formatted ).toMatch( JSONRegex );

            } );
            
        } );
        
    }
    
}