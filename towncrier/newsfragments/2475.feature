Upgrade the anti-spoofing rule. We shouldn't assume that Mailu is the only MTA allowed to send emails on behalf of the domains it hosts... but we should also ensure that both the envelope from and header from are checked.
