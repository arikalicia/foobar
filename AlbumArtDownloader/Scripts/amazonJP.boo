namespace CoverSources
import System.Xml
import System.Drawing
import util

class AmazonJP:
	static SourceName as string:
		get: return "Amazon.co.jp"
	static SourceVersion as decimal:
		get: return 0.21
	static def GetThumbs(coverart,artist,album):
		x=System.Xml.XmlDocument()
		x.Load("http://ecs.amazonaws.jp/onca/xml?Service=AWSECommerceService"
			+ "&AWSAccessKeyId=1MV23E34ARMVYMBDZB02"
			+ "&SearchIndex=Music&Sort=&ResponseGroup=Medium"
			+ "&Operation=ItemSearch&Keywords=" + EncodeUrl(artist+" "+album))
		results=x.GetElementsByTagName("Item")
		coverart.SetCountEstimate(results.Count)
		for node in results:
			image=node["LargeImage"]
			attribute=node["ItemAttributes"]
			thumb=System.Drawing.Bitmap.FromStream(GetPageStream(image["URL"].InnerText))
			coverart.AddThumb(
				thumb,
				attribute["Title"].InnerText,
				thumb.Width, thumb.Height,
				image["URL"].InnerText)
		
	static def GetResult(param):
		return param
