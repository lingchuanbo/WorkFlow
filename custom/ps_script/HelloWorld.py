from win32com.client import Dispatch

app = Dispatch("Photoshop.Application")
doc = app.Documents.Add(512, 512)
layerRef = doc.ArtLayers.Add()

psTextLayer = 2  # from enum PsLayerKind
layerRef.Kind = psTextLayer

textItem = layerRef.TextItem
textItem.Contents = "HELLO WORLD!"
textItem.Position = (256, 256)