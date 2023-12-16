extends Node

#region SaveLoadManager

signal SaveGame(data : SaveData)
signal LoadGame(data : SaveData)

#endregion

#region StageManager

signal FinishedLoading()

#endregion

#region Notification

signal SendNotification(body : String, icon : String, header : String)

#endregion
