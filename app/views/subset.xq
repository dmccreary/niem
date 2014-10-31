xquery version "1.0";
import module namespace mdr = "http://mdr.example.com" at "/db/mdr/modules/mdr.xq";
declare namespace exist = "http://exist.sourceforge.net/NS/exist"; 
declare namespace xsd = "http://www.w3.org/2001/XMLSchema";
declare namespace system="http://exist-db.org/xquery/system";
declare namespace request="http://exist-db.org/xquery/request";
declare option exist:serialize "method=xhtml media-type=text/xml indent=yes";
 
let $wantlist := request:get-parameter('wantlist', '')
return
if (string-length($wantlist) < 1)
   then (
        <results>
           <message>Error: "wantlist" is a required parameter.</message>
        </results>
    )
    else (
        let $wantlist-collection := '/db/mdr/wantlists/data'
        let $file-path := concat($wantlist-collection, '/', $wantlist, '.xml')
        let $doc := doc($file-path)
        return
            <xsd:schema 
            xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
            xmlns:e="http://metadata.example.com" 
            targetNamespace="{$doc//NamespaceURI/text()}">
               <xsd:annotation>
                   <xsd:documentation>
                      <wantlist>{$wantlist}</wantlist>
                      <path>{$file-path}</path>
                   </xsd:documentation>
                     </xsd:annotation>
               {for $element in $doc//Element
                   let $prefix := 'p:'
                   let $simpleType := 
                      if (ends-with($element, 'Code'))
                              then
                                 (<xsd:simpleType name="{concat($element/text(), 'Type')}">
                                     <xsd:annotation>
                                            <xsd:documentation>{mdr:get-definition-for-element($element)}</xsd:documentation>
                                     </xsd:annotation>
                                     {mdr:get-restrictions-for-element($element/text())}
                               </xsd:simpleType>
                               )
                      else ()                    
                    let $elementDef := <xsd:element name="{$element/text()}" 
                    type="{if (ends-with($element, 'Code')) 
                       then (concat($prefix, $element/text(), 'Type'))
                       else (mdr:get-xml-schema-datatype-for-element($element))}" nillable="true">
                         <xsd:annotation>
                                <xsd:documentation>{mdr:get-definition-for-element($element)}</xsd:documentation>
                         </xsd:annotation>
                    </xsd:element>
 
                    return ($simpleType, $elementDef)
               }
            </xsd:schema>
)