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
declare namespace term="http://release.niem.gov/niem/localTerminology/3.0/";

let $title := 'NIEM Classes to HTML'

(: This is the file path.  Change this line if you put the file into another location :)
let $file-path := '/db/apps/niem/data/niem-core-v3.xsd'
let $doc := doc($file-path)

let $content :=
<div class="content">
   <h1>NIEM Core Classes to HTML</h1>
   File = {$file-path}<br/>
  
  <div class="row">
    <div class="col-md-4">
          <table class="table table-striped table-bordered table-hover table-condensed">
          <thead>
               <tr>
                  <th>Metric</th>
                  <th>Value</th>
               </tr>
            </thead>
            <tbody>
                <tr>
                   <td>Number of Complex Types: </td>
                   <td>{count($doc//xsd:complexType)}</td>
                </tr>
                <tr>
                   <td>Number of Named Complex Types: </td>
                   <td>{count($doc//xsd:complexType[@name])}</td>
                </tr>
                <tr>
                   <td>Number of Elements: </td>
                   <td>{count($doc//xsd:element)}</td>
                </tr>
                <tr>
                   <td>Number of Imports: </td>
                   <td>{count($doc//xsd:import)}</td>
                </tr>
                <tr>
                   <td>Local Terms: </td>
                   <td>{count($doc//term:LocalTerm)}</td>
                </tr>
                <tr>
                   <td>Annotations: </td>
                   <td>{count($doc//xsd:annotation)}</td>
                </tr>
            </tbody>
          </table>
    </div>
  </div>
</div>

return style:assemble-page($title, $content)