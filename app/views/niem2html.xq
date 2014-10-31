xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "../modules/style.xqm";

(:
This XQuery Script Transforms NIEM Core Elements from input XML Schema file into
an HTML file.
	     
    Author:Dan McCreary
    Copyright: 2013 Kelly-McCreary & Associates, All Rights Reserved
    License: Apache 2.0
    Version History:
		
:)
declare namespace s="http://niem.gov/niem/structures/2.0";
declare namespace nc="http://niem.gov/niem/niem-core/2.0";
declare namespace niem-xsd="http://niem.gov/niem/proxy/xsd/2.0";
declare namespace xsd="http://www.w3.org/2001/XMLSchema";
declare namespace j="http://niem.gov/niem/domains/jxdm/4.0";
declare namespace i="http://niem.gov/niem/appinfo/2.0";

let $title := 'NIEM Classes to HTML'

(: This is the file path.  Change this line if you put the file into another location :)
let $file-path := '/db/apps/niem/data/niem-core-v3.xsd'
let $doc := doc($file-path)

let $content :=
<div class="content">
   <h1>NIEM Core Classes to HTML</h1>
      {
        (: We first get all the complex elements in the file.  For each complex element create an owl class. :)
        for $complex-element at $count in $doc//xsd:complexType[@name]
            let $name := string($complex-element/@name)
            order by $name
              return
                 (: for each class, put the class name in and put the parent class in the subclass element :)
                 <div class="niem-class">
                     <span class="niem-label">Class:</span>
                     <span class="niem-class-name">{$name}</span><br/>
                     <span class="niem-label">Sub class of:</span> {string($complex-element//xsd:extension/@base)}<br/>
                     <span class="niem-label">Documentation:</span> {$complex-element/xsd:annotation/xsd:documentation/text()}<br/>
                     <span class="niem-label">Properties:</span>
                     {
                        (: now create a sequence of the sorted properties of the class :)
                        let $sorted-sub-elements := 
                           for $element at $count in $complex-element//xsd:element
                              let $name := string($element/@ref)
                              order by $name
                              return $element
                         
                            (: Now for each sub-element in the class, create a datatypeproperty.
                            I am omiting the owl label for simplicity and to keep the file size small :)
                            for $sub-element in $sorted-sub-elements
                               let $name := substring-after($sub-element/@ref, "nc:")
                            return
                            <div class="property">{$name}</div>
                      }
             </div>     
     }
</div>

return style:assemble-page($title, $content)