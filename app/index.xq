xquery version "1.0";
import module namespace style = "http://danmccreary.com/style" at "modules/style.xqm";


let $title := 'NIEM Transform Library'

let $content :=
<div class="content">
        <h4>Reports</h4>
        <a href="views/niem2html.xq">NIEM to HTML</a><br/>
        <a href="views/niem2owl.xq">NIEM to OWL</a><br/>
        <a href="views/metrics.xq">V3 Metrics Report</a><br/>
     
        <h4>Data Sources</h4>
        <a href="data/niem-core-v3.xsd">NIEM Core Version 3</a><br/>
        <a href="data/niem-core.xsd">NIEM Core Version 2</a><br/>
        
        
        <h4>Related Wikibooks</h4>
        <a href="http://en.wikibooks.org/wiki/XRX/Subset_Generator">Wikibook Article on Subset Generator</a><br/>
        
        <a href="http://en.wikibooks.org/wiki/XRX/Metadata_Shopper">Metadata Shopper</a>
        <a href="http://release.niem.gov/niem/3.0/">NIEM 3.0 Release Notes</a><br/>
</div>

return style:assemble-page($title, $content)