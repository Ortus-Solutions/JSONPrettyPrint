/**
*********************************************************************************
* Copyright Since 2014 by Ortus Solutions, Corp
* www.coldbox.org | www.ortussolutions.com
********************************************************************************
* @author Brad Wood, Luis Majano
*
*/
component accessors="true" singleton alias='JSONPrettyPrint' {

    property CFMLPrinter;
    property JSONPrinter;
    property DefaultPrinter;

    function init( string defaultPrinter = '' ) {
        if ( !len( defaultPrinter ) ) {
            if ( server.coldfusion.productname == 'Lucee' && listFirst( server.lucee.version, '.' ) >= 5 ) {
                defaultPrinter = 'CFMLPrinter';
            } else {
                defaultPrinter = 'JSONPrinter';
            }
        }
        setJSONPrinter( new JSONPrinter() );
        setCFMLPrinter( new CFMLPrinter() );
        setDefaultPrinter( variables[ defaultPrinter ] );
        variables.os = createObject( 'java', 'java.lang.System' ).getProperty( 'os.name' ).toLowerCase();
        return this;
    }

    // OS detector
    private boolean function isWindows() {
        return variables.os.contains( 'win' );
    }

    /**
     * Pretty JSON
     * @json A string containing JSON, or a complex value that can be serialized to JSON
     * @indent String to use for indenting lines.  Defaults to four spaces.
     * @lineEnding String to use for line endings.  Defaults to CRLF on Windows and LF on *nix
     * @spaceAfterColon Add space after each colon like "value": true instead of"value":true
     * @sortKeys Specify a sort type to sort the keys of json objects: "text" or "textnocase"
     **/
    public function formatJson(
        any json,
        string indent = '    ',
        lineEnding,
        boolean spaceAfterColon = false,
        string sortKeys = ''
    ) {
        // Default line ending based on OS
        if( isNull( arguments.lineEnding ) ) {
            if( isWindows() ) {
                arguments.lineEnding = chr( 13 ) & chr( 10 );
            } else {
                arguments.lineEnding = chr( 10 );
            }
        }

        return getDefaultPrinter().formatJson( argumentCollection = arguments );
    }

}
