EGuildDuty
{
  GUILD_DUTY_NORMAL = 1,                                --普通会员
  GUILD_DUTY_JINGYING = 2,                              --精英
  GUILD_DUTY_YUANLAO = 3,                               --元老
  GUILD_DUTY_VICE_CHAIRMAN = 4,                         --副会长
  GUILD_DUTY_CHAIRMAN = 5,                              --会长
}
EInstType
{
  GUILD_INST_TYPE_BOSS = 0,		--公会boss副本
  GUILD_INST_TYPE_INST = 1,		--公会副本
  GUILD_INST_TYPE_MAX,
}

local GuildListWidget = require "UI/Guild/GuildListWidget"
local GuildCreateWidget = require "UI/Guild/GuildCreateWidget"
local GuildApplyListWidget = require "UI/Guild/GuildApplyListWidget"
local GuildDetaildWidget = require "UI/Guild/GuildDetaildWidget"
local GuildMemberManWidget = require "UI/Guild/GuildMemberManWidget"
local DlgGuild = class("DlgGuild", DlgBase)
DlgGuild_Name = "ui_guild"

function DlgGuild:ctor()
  self.mCurrentTabIdx = 0
  self.mGuildGroups = nil
  self.mGuildListWidget = nil
  self.mGuildCreateWidget = nil
  self.mGuildApplyListWidget = nil
  self.mGuildDetailWidget = nil
  self.mGuildMemberManWidget = nil
end

function DlgGuild:Init()
  --GuildListWidget Message
  UIEventHandler:RegistEvent(UIEvent.EVENT_UPDATE_GUILDLIST, self)
  --GuildInstanceWidget Message
  UIEventHandler:RegistEvent(UIEvent.EVENT_UPDATE_GUILDINST_CHANGE, self)
  --GuildBossWidget Message
  UIEventHandler:RegistEvent(UIEvent.EVENT_UPDATE_GUILDBOSS_CHANGE, self)
  --GuildLogWidget Message
  UIEventHandler:RegistEvent(UIEvent.EVENT_UPDATE_GUILD_NEWLOGMSG, self)
  --GuildRewardWidget Message
  UIEventHandler:RegistEvent(UIEvent.EVENT_UPDATE_TASK_INFO, self)
end

function DlgGuild:OnOpen()
  GameManager:HostPlayer():GetGuildMgr():TryRequestSelfGuildInfo(false)
  --C2S.c2s_QueryGuildLogs();
  self:OnGuildStatusChange()
end

function DlgGuild:OnClose()
  DlgBase:OnClose()
  self.mCurrentTabIdx = 0
  local hostPlayer = GameManager:HostPlayer()
  if hostPlayer ~= nil then
    hostPlayer:GetGuildMgr():GetHostPlayer()
    hostPlayer:GetGuildMgr():ResetGuildList()
  end
end

function DlgGuild:OnDestroy()
  DlgBase:OnDestroy()
  UIEventHandler:UnRegistEvent(UIEvent.EVENT_UPDATE_GUILDLIST, self)
  UIEventHandler:UnRegistEvent(UIEvent.EVENT_UPDATE_GUILDINST_CHANGE, self)
  UIEventHandler:UnRegistEvent(UIEvent.EVENT_UPDATE_GUILDBOSS_CHANGE, self)
  UIEventHandler:UnRegistEvent(UIEvent.EVENT_UPDATE_GUILD_NEWLOGMSG, self)
  UIEventHandler:UnRegistEvent(UIEvent.EVENT_UPDATE_TASK_INFO, self)
end

function DlgGuild:DispatchUIEvent(event,...)
  local arg = {...}
  if event == UIEvent.EVENT_UPDATE_GUILDLIST then
    if self.mGuildListWidget ~= nil then
      self.mGuildListWidget:ShowGuildList()
    end
  elseif event == UIEvent.EVENT_UPDATE_GUILDINST_CHANGE then

  elseif event == UIEvent.EVENT_UPDATE_GUILDBOSS_CHANGE then

  elseif event == UIEvent.EVENT_UPDATE_GUILD_NEWLOGMSG then

  elseif event == UIEvent.EVENT_UPDATE_TASK_INFO then

  end
end

function DlgGuild:CloseGuildPanel(obj)
  self:Show(false)
end

function DlgGuild:OnGuildMemberChange()
  --[[if self.mGuildDetailWidget ~= nil then
		self.mGuildDetailWidget:RefreshGuildMembers()
	end--]]
  if self.mGuildMemberManWidget ~= nil then
    self.mGuildMemberManWidget:ShowGuildMembers()
  end
end

function DlgGuild:ResetGuildApplyRequest()
  if self.mGuildApplyListWidget ~= nil then
    self.mGuildApplyListWidget:ShowApplyList()
  end
end

function DlgGuild:ShowDonateConfirm(bShow)
  if self.mGuildDetailWidget ~= nil then
    self.mGuildDetailWidget:Show(bShow)
  end
end

function DlgGuild:OnGuildStatusChange()
  local hostPlayer = GameManager:HostPlayer()
  if hostPlayer ~= nil then
    if hostPlayer:GetGuildMgr():GetHasGuild() then
      if self.mGuildCreateWidget ~= nil then
        self.mGuildCreateWidget:Show(false)
      end

      if self.mGuildGroups ~= nil then
        self.mGuildGroups:SetActive(true)
      end
      --TODO zrc
      self:UpdateCornerIcon()
    else
      if self.mGuildCreateWidget ~= nil then
        self.mGuildCreateWidget:Show(true)
      end

      if self.mGuildGroups ~= nil then
        self.mGuildGroups:SetActive(false)
      end
    end
  end
end

function DlgGuild:UpdateCornerIcon()

end

return DlgGuild
